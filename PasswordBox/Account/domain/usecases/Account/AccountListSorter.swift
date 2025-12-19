//
//  AccountListManager.swift
//  PasswordBox
//
//  Created by 이민호 on 11/21/25.
//

import Foundation
import Resolver
import Combine

protocol AccountListSorter {
    func sort(wrappers: [AccountInfoWrapper]) async throws -> [AccountInfoWrapper]
    func sort(wrappers: [AccountInfoWrapper], order: AccountOrder, orderBy: AccountOrderBy) -> [AccountInfoWrapper]
}

class DefaultAccountListSorter: AccountListSorter {
    @Injected var userService: UserService
    
    func sort(wrappers: [AccountInfoWrapper]) async throws -> [AccountInfoWrapper] {
        let (order, orderBy) = try await userService.getOrderAndOrderBy()        
        
        switch orderBy {
        case .title:
            switch order {
            case .ascending:
                return wrappers.sorted { $0.sitename < $1.sitename }
            case .descending:
                return wrappers.sorted { $0.sitename > $1.sitename }
            }
        case .createDate:
            switch order {
            case .ascending:
                return wrappers.sorted { $0.createDate < $1.createDate }
            case .descending:
                return wrappers.sorted { $0.createDate > $1.createDate }
            }
        case .updateDate:
            switch order {
            case .ascending:
                return wrappers.sorted { $0.updateDate < $1.updateDate }
            case .descending:
                return wrappers.sorted { $0.updateDate > $1.updateDate }
            }
        }
    }
    
    func sort(wrappers: [AccountInfoWrapper], order: AccountOrder, orderBy: AccountOrderBy) -> [AccountInfoWrapper] {
        
        switch orderBy {
        case .title:
            switch order {
            case .ascending:
                return wrappers.sorted { $0.sitename < $1.sitename }
            case .descending:
                return wrappers.sorted { $0.sitename > $1.sitename }
            }
        case .createDate:
            switch order {
            case .ascending:
                return wrappers.sorted { $0.createDate < $1.createDate }
            case .descending:
                return wrappers.sorted { $0.createDate > $1.createDate }
            }
        case .updateDate:
            switch order {
            case .ascending:
                return wrappers.sorted { $0.updateDate < $1.updateDate }
            case .descending:
                return wrappers.sorted { $0.updateDate > $1.updateDate }
            }
        }
    }
}
