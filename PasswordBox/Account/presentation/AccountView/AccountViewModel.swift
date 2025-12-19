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

@MainActor
class AccountViewModel: ObservableObject, @MainActor ControlMessageBindable {
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    @Injected var accountSubject: PassthroughSubject<AccountMessage, Never>    
    @Injected var cloudManager: CloudManager
        
    @Published var isShowingAccountAddSheet = false
    @Published var isShowingSocialAccountAddSheet: Bool = false
    var cancellables: Set<AnyCancellable> = []
        
    init() {        
        setupControlMessageBindng()
    }
    
//    func triggerCloudSync() {
//        controlSubject.send(.connectingCloud)
//        
//        Task { [weak self] in
//            guard let self else { return }
//            let result = await cloudManager.awaitSyncCycle(maxWait: 10)
//            
//            switch result {
//            case .success:
//                print("☁️ Cloud연결 성공")
//                controlSubject.send(.cloudConnected)
//                
//            case .failure(let error):
//                print("⚠️ Cloud연결 실패: \(error.localizedDescription)")
//                controlSubject.send(.cloudConnectionFailed)
//            }
//        }
//    }
    
    private func setupControlMessageBindng() {
        bindControlMessage { [weak self] message in
            switch message {                            
            case .toggleIsShowingAccountAddSheet:
                self?.isShowingAccountAddSheet.toggle()
            case .toggleIsShowingSocialAccountSheet:
                self?.isShowingSocialAccountAddSheet.toggle()
            default:
                return
            }
        }
    }
}
