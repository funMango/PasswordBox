//
//  SiteViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 8/11/25.
//

import Foundation
import Resolver
import Combine

class SiteViewModel: ObservableObject, ControlMessageBindable {
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    @Published var isShowingSiteAddSheet = false
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        setupControlMessageBindng()
    }
    
    func setupControlMessageBindng() {
        bindControlMessage { message in
            switch message {
            case .toggleIsShowingSiteAddSheet:                
                self.isShowingSiteAddSheet.toggle()
            default:
                return
            }
        }
    }
}
