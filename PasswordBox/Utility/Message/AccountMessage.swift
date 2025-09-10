//
//  SiteMessage.swift
//  PasswordBox
//
//  Created by 이민호 on 9/2/25.
//

import Foundation
import Combine

enum AccountMessage {
    case changeSearchText(String)
    case updateAccountCredentials(AccountCredentials)
    case updateSitename(String)
}

protocol AccountMessageBindable: AnyObject {
    var accountSubject: PassthroughSubject<AccountMessage, Never> { get }
    var cancellables: Set<AnyCancellable> { get set }
}

extension AccountMessageBindable {
    func bindAccountMessage(action: @escaping (AccountMessage) -> Void) {
        accountSubject
            .sink(receiveValue: action)
            .store(in: &cancellables)
    }
}
