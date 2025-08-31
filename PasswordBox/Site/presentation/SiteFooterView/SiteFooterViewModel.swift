//
//  SiteFooterViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 8/11/25.
//

import Foundation
import Resolver
import Combine

class SiteFooterViewModel: ObservableObject {
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    
    func toggleIsShowingSiteAddSheet() {        
        controlSubject.send(.toggleIsShowingSiteAddSheet)
    }
}
