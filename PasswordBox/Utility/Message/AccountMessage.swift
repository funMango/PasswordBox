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
    
    case selectAccount(Account)
    case selectSite(String)
    
    /// sort
    case sortByDescending
    case sortByAscending
    case sortByUpdateDate
    case sortByCreateDate
    case sortByTitle
    
    case setOrder(AccountOrder)
    case setOrderBy(AccountOrderBy)
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
