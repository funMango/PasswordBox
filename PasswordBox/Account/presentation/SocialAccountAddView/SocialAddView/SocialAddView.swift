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
                textBinding: $viewModel.text,
                onSubmit: {
                    viewModel.updateSite()
                }
            )
            
            AccountFilteredSectionView(
                filteredItems: $viewModel.filteredAccounts,
                text: viewModel.text,
                updateItem: viewModel.updateSite,
                setItem: { account in
                    viewModel.updateAccount(account)
                },
                cellView: { account in
                    AccountListCellView(
                        sitename: account.sitename,
                        username: account.username
                    )
                }
            )
        }
        .scrollDismissesKeyboard(.immediately)
        .onDisappear {
            viewModel.reset()
        }
    }
}

#Preview {
    SocialAddView()
}
