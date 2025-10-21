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
