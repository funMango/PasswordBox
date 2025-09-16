//
//  ControlMessage.swift
//  PasswordBox
//
//  Created by 이민호 on 8/11/25.
//

import Foundation
import Combine

enum ControlMessage{
    case toggleIsShowingAccountAddSheet
    case toggleIsShowingSocialAccountSheet
    case changeSearchBarState
    case setupSiteOrder(AccountOrder, AccountOrderBy)
    case activateSiteTextField
    case updateSitename(String)
    case changeAccountInfoState(Bool)
}

protocol ControlMessageBindable: AnyObject {
    var controlSubject: PassthroughSubject<ControlMessage, Never> { get }
    var cancellables: Set<AnyCancellable> { get set }
}

extension ControlMessageBindable {
    func bindControlMessage(action: @escaping (ControlMessage) -> Void) {
        controlSubject
            .sink(receiveValue: action)
            .store(in: &cancellables)
    }
}
