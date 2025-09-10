//
//  SiteViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 8/11/25.
//

import Foundation
import Resolver
import Combine

class AccountViewModel: ObservableObject, ControlMessageBindable {
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    @Injected var userService: UserService
    @Published var isShowingSiteAddSheet = false
    @Published var user: User? = nil
    var cancellables: Set<AnyCancellable> = []
    
    
    init() {
        setupControlMessageBindng()
        sendControlMessage()
        setupUser()
    }
    
    func setupUser() {
        self.user = userService.fetch()
        
        if let user = self.user {
            print(user.id)
        }
    }
    
    func setupControlMessageBindng() {
        bindControlMessage { message in
            switch message {
            case .toggleIsShowingAccountAddSheet:                
                self.isShowingSiteAddSheet.toggle()
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
