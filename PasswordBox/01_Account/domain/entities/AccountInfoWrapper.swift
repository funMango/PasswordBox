//
//  AccountInfo.swift
//  PasswordBox
//
//  Created by 이민호 on 9/30/25.
//

import SwiftUI

enum AccountInfoWrapper: Equatable, Hashable {
    case account(Account, fallbackSitename: String?)
    case social(SocialAccount)
    
    var id: String {
        switch self {
        case .account(let acc, _): return acc.id
        case .social(let soc): return soc.id
        }
    }
    
    var sitename: String {
        switch self {
        case .account(let acc, _): return acc.sitename
        case .social(let soc): return soc.sitename
        }
    }
    
    var username: String? {
        switch self {
        case .account(let acc, let fallback):
            return acc.username.isEmpty ? fallback : acc.username
        case .social(let soc): return soc.username
        }
    }
    
    var socialSiteName: String? {
        switch self {
        case .account(_, _): return nil
        case .social(let soc): return soc.socialSitename
        }
    }
    
    var createDate: Date {
        switch self{
        case .account(let acc, _): return acc.createDate
        case .social(let soc): return soc.createDate
        }
    }
    
    var updateDate: Date {
        switch self{
        case .account(let acc, _): return acc.updateDate
        case .social(let soc): return soc.updateDate
        }
    }
    
    @ViewBuilder
        var destinationView: some View {
            switch self {
            case .account(let acc, _):
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
        case .account(let acc, let fallback):
            let usesFallback = acc.username.isEmpty && fallback != nil
            let subTitle = acc.username.isEmpty ? (fallback ?? "") : acc.username
            AccountListCellView(
                title: acc.sitename,
                subTitle: subTitle,
                showsLinkIcon: usesFallback
            )
            
        case .social(let soc):            
            AccountListCellView(
                title: soc.sitename,
                subTitle: soc.socialSitename
            )
        }
    }
    
    @ViewBuilder
    func cellHighlightedView(query: String) -> some View {
        switch self {
        case .account(let acc, let fallback):
            let usesFallback = acc.username.isEmpty && fallback != nil
            let displayUsername = acc.username.isEmpty ? (fallback ?? "") : acc.username
            AccountListHighlightCellView(
                sitename: acc.sitename,
                username: displayUsername,
                query: query,
                showsLinkIcon: usesFallback
            )
        case .social(let soc):
            AccountListHighlightCellView(
                sitename: soc.sitename,
                username: soc.socialSitename,
                query: query
            )
        }
    }
}

extension AccountInfoWrapper {
    func matchBySitename(query: String) -> Bool {
        return fuzzyUnorderedContains(text: self.sitename, query: query)
    }
    
    func matchBySocialSiteNameOrUsername(query: String) -> Bool {
        if let candidate = self.socialSiteName ?? self.username,
           fuzzyUnorderedContains(text: candidate, query: query) {
            return true
        }
        
        return false
    }
}
