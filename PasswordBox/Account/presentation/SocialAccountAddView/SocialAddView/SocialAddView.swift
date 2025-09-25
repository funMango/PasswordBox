//
//  SocialAddView.swift
//  PasswordBox
//
//  Created by 이민호 on 9/20/25.
//

import SwiftUI

struct SocialAddView: View {
    @StateObject var viewModel = SocialAddViewModel()
    
    var body: some View {
        List {
            SearchSectionView(
                placeholder: "searchSiteOrAccount",
                textBinding: Binding(
                    get: { viewModel.text },
                    set: { newValue in
                        viewModel.text = newValue
                        viewModel.objectWillChange.send()
                    }
                ),
                onSubmit: {
                    viewModel.updateSite()
                }
            )
            
            AccountFilteredSectionView(
                filteredAccounts: viewModel.filteredAccounts,
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
    }        
}

#Preview {
    SocialAddView()
}
