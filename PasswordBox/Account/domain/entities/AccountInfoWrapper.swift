//
//  AccountInfo.swift
//  PasswordBox
//
//  Created by 이민호 on 9/30/25.
//

import SwiftUI

enum AccountInfoWrapper: Equatable, Hashable {
    case account(Account)
    case social(SocialAccount)
    
    var id: String {
        switch self {
        case .account(let acc): return acc.id
        case .social(let soc): return soc.id
        }
    }
    
    var sitename: String {
        switch self {
        case .account(let acc): return acc.sitename
        case .social(let soc): return soc.sitename
        }
    }
    
    var username: String? {
        switch self {
        case .account(let acc): return acc.username
        case .social(let soc): return soc.username
        }
    }
    
    var socialSiteName: String? {
        switch self {
        case .account(_): return nil
        case .social(let soc): return soc.socialSitename
        }
    }
    
    var createDate: Date {
        switch self{
        case .account(let acc): return acc.createDate
        case .social(let soc): return soc.createDate
        }
    }
    
    var updateDate: Date {
        switch self{
        case .account(let acc): return acc.updateDate
        case .social(let soc): return soc.updateDate
        }
    }
    
    @ViewBuilder
        var destinationView: some View {
            switch self {
            case .account(let acc):
                AccountDetailView(viewModel: AccountDetailViewModel(account: acc))
            case .social(let soc):
                SocialAccountDetailView(
                    viewModel: SocialAccountDetailViewModel(socialAccount: soc)
                )
            }
        }

    @ViewBuilder
    var cellView: some View {
        switch self {
        case .account(let acc):
            AccountListCellView(
                sitename: acc.sitename,
                username: acc.username
            )
            
        case .social(let soc):            
            AccountListCellView(
                sitename: soc.sitename,
                username: soc.socialSitename
            )
        }
    }
}

extension AccountInfoWrapper {
    func matches(query: String) -> Bool {
        // sitename이 매칭되면 true
        if fuzzySubsequenceMatch(text: self.sitename, query: query) {
            return true
        }

        // socialSiteName이 있으면 그것을 우선 사용하고, 없으면 username 사용
        if let candidate = self.socialSiteName ?? self.username,
           fuzzySubsequenceMatch(text: candidate, query: query) {
            return true
        }

        return false
    }
}

extension Array where Element == AccountInfoWrapper {
    func filtered(by query: String) -> [AccountInfoWrapper] {
        guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return self }
        return self.filter { $0.matches(query: query) }
    }
}
