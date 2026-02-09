//
//  SocialAddView.swift
//  PasswordBox
//
//  Created by 이민호 on 9/20/25.
//

import SwiftUI

struct SocialAddView: View {
    @StateObject var viewModel = SocialAddViewModel(filter: SocialAccountFilter())
    
    var body: some View {
        List {
            SearchSectionView(
                placeholder: "searchSiteOrAccount",
                textBinding: $viewModel.text
            )
            
            SocialFilteredSectionView(
                filteredItems: $viewModel.filteredAccounts,
                text: viewModel.text,
                setItem: { account in
                    viewModel.updateAccount(account)
                },
                cellView: { account in
                    let fallback = viewModel.fallbackSitename(for: account)
                    let usesFallback = account.username.isEmpty && fallback != nil
                    AccountListCellView(
                        title: account.sitename,
                        subTitle: account.username.isEmpty ? (fallback ?? "") : account.username,
                        showsLinkIcon: usesFallback
                    )
                }
            )
        }
        .task {
            viewModel.setupAccounts()
        }
        .scrollDismissesKeyboard(.immediately)
        .onDisappear {
            // viewModel.reset()
        }
    }
}

#Preview {
    SocialAddView()
}
