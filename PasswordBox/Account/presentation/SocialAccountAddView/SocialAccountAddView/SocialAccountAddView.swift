//
//  SocialAccountAddView.swift
//  PasswordBox
//
//  Created by 이민호 on 9/15/25.
//

import SwiftUI

struct SocialAccountAddView: View {
    @StateObject var viewModel = SocialAccountAddViewModel()
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationStack {
            List {
                SearchSectionView(
                    placeholder: "searchOrCreateSite",
                    textBinding: Binding(
                        get: { viewModel.text },
                        set: { newValue in
                            viewModel.text = newValue
                            viewModel.objectWillChange.send()
                        }
                    )
                )
                
                SocialAccountSelectedView()
                
                AccountFilteredSectionView(
                    filteredAccounts: viewModel.filteredAccounts,
                    text: viewModel.text,
                    updateItem: {
                        viewModel.updateSite()
                    },
                    setItem: { account in
                        viewModel.updateAccount(from: account)
                    },
                    cellView: { account in
                        AccountListCellView(
                            sitename: account.sitename,
                            username: account.username
                        )
                    }
                )
            }
            .navigationTitle(String(localized: "addAccount.social.title"))
            .navigationBarTitleDisplayMode(.inline)
            .scrollDismissesKeyboard(.immediately)
        }
    }
}

#Preview {
    SocialAccountAddView()
}
