//
//  IcloudStateViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 12/10/25.
//

import Foundation
import Resolver
import Combine
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
    
    init() {
        triggerCloudSync()
    }
    
    func triggerCloudSync() {
        self.state = .syncing
        
        Task { [weak self] in
            guard let self else { return }
            let result = await cloudManager.awaitSyncCycle(maxWait: 10)
            
            switch result {
            case .success:
                print("☁️ Cloud연결 성공")
                self.state = .idle
                controlSubject.send(.cloudConnected)
                
            case .failure(let error):
                print("⚠️ Cloud연결 실패: \(error.localizedDescription)")
                self.state = .notConnected
                controlSubject.send(.cloudConnectionFailed)
            }
        }
    }
}
