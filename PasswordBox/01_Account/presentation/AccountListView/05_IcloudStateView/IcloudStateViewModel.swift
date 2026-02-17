//
//  IcloudStateViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 12/10/25.
//

import Foundation
import Resolver
import Combine
import UIKit
// import CoreData

enum CloudState: String {
    case idle
    case syncing = "icloud"
    case notConnected = "icloud.slash"
}

@MainActor
class IcloudStateViewModel: ObservableObject {
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    @Injected var cloudManager: CloudManager
    @Published var state: CloudState = .idle
    
    private var retryTask: Task<Void, Never>?
    private var didBecomeActiveObserver: NSObjectProtocol?
    private var didEnterBackgroundObserver: NSObjectProtocol?
    private var isSyncInProgress = false
    private var isConnected = false
    private var isAppActive = true
    
    private let initialRetryDelay: UInt64 = 5_000_000_000
    private let maxRetryDelay: UInt64 = 60_000_000_000
    
    init() {
        setupLifecycleObservers()
        startRetryLoopIfNeeded(immediate: true)
    }
    
    deinit {
        retryTask?.cancel()
        
        if let observer = didBecomeActiveObserver {
            NotificationCenter.default.removeObserver(observer)
        }
        
        if let observer = didEnterBackgroundObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    private func setupLifecycleObservers() {
        didBecomeActiveObserver = NotificationCenter.default.addObserver(
            forName: UIApplication.didBecomeActiveNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            Task { @MainActor in
                guard let self else { return }
                self.isAppActive = true
                if !self.isConnected {
                    self.startRetryLoopIfNeeded(immediate: true)
                }
            }
        }
        
        didEnterBackgroundObserver = NotificationCenter.default.addObserver(
            forName: UIApplication.didEnterBackgroundNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            Task { @MainActor in
                guard let self else { return }
                self.isAppActive = false
                self.stopRetryLoop()
            }
        }
    }
    
    private func startRetryLoopIfNeeded(immediate: Bool) {
        guard retryTask == nil else { return }
        guard !isConnected else { return }
        
        retryTask = Task { [weak self] in
            guard let self else { return }
            await self.runRetryLoop(immediate: immediate)
        }
    }
    
    private func stopRetryLoop() {
        retryTask?.cancel()
        retryTask = nil
    }
    
    private func runRetryLoop(immediate: Bool) async {
        var delay: UInt64 = immediate ? 0 : initialRetryDelay
        
        while !Task.isCancelled {
            if !isAppActive { break }
            
            if delay > 0 {
                try? await Task.sleep(nanoseconds: delay)
            }
            
            if Task.isCancelled || !isAppActive { break }
            
            let isSuccessful = await triggerCloudSync()
            if isSuccessful { break }
            
            delay = (delay == 0) ? initialRetryDelay : min(delay * 2, maxRetryDelay)
        }
        
        retryTask = nil
    }
    
    @discardableResult
    private func triggerCloudSync() async -> Bool {
        guard !isConnected else { return true }
        guard !isSyncInProgress else { return false }
        
        isSyncInProgress = true
        state = .syncing
        controlSubject.send(.connectingCloud)
        
        defer {
            isSyncInProgress = false
        }
        
        let result = await cloudManager.awaitSyncCycle(maxWait: 10)
        
        switch result {
        case .success:
            print("☁️ Cloud연결 성공")
            isConnected = true
            state = .idle
            controlSubject.send(.cloudConnected)
            return true
            
        case .failure(let error):
            print("⚠️ Cloud연결 실패: \(error.localizedDescription)")
            state = .notConnected
            controlSubject.send(.cloudConnectionFailed)
            return false
        }
    }
}
