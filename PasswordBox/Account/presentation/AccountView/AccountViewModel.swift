//
//  SiteViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 8/11/25.
//

import Foundation
import Resolver
import Combine
import CoreData

class AccountViewModel: ObservableObject, ControlMessageBindable {
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    @Injected var userService: UserService
    @Published var isSyncing: Bool = false
    @Published var isShowingAccountAddSheet = false
    @Published var isShowingSocialAccountAddSheet: Bool = false
    @Published var user: User? = nil
    var cancellables: Set<AnyCancellable> = []
    
    
    init() {
        setupControlMessageBindng()
        sendControlMessage()
        syncCloud()
    }
    
    private func syncCloud() {
        NotificationCenter.default.addObserver(
            forName: NSPersistentCloudKitContainer.eventChangedNotification,
            object: nil,
            queue: .main
        ) { [weak self] note in
            guard let event = note.userInfo?[NSPersistentCloudKitContainer.eventNotificationUserInfoKey] as? NSPersistentCloudKitContainer.Event else { return }
            
            DispatchQueue.main.async {
                // endDate가 nil → 아직 진행 중
                if event.endDate == nil {
                    self?.isSyncing = true
                } else {
                    self?.isSyncing = false
                    if event.type == .import {
                        self?.setupUser()
                    }
                }
            }
        }
    }
    
    private func setupUser() {
        self.user = userService.fetch()
        
        if let user = self.user {
            print(user.id)
        }
    }
    
    private func setupControlMessageBindng() {
        bindControlMessage { message in
            switch message {
            case .toggleIsShowingAccountAddSheet:                
                self.isShowingAccountAddSheet.toggle()
            case .toggleIsShowingSocialAccountSheet:
                self.isShowingSocialAccountAddSheet.toggle()
            default:
                return
            }
        }
    }
    
    func sendControlMessage() {
        $user
            .compactMap{ $0 }
            .sink { [weak self] user in
                print("😆 User Load Complete | user ID: \(user.id)")
                self?.controlSubject.send(.setupSiteOrder(user.siteOrder, user.siteOrderBy))
            }
            .store(in: &cancellables)
    }
}
