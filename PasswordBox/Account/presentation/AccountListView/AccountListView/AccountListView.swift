//
//  SiteListView.swift
//  PasswordBox
//
//  Created by 이민호 on 8/11/25.
//

import SwiftUI
import SwiftData

struct AccountListView: View {
    @StateObject var viewModel = AccountListViewModel()
    @Query var accounts: [AccountDTO]
    
    var body: some View {
        List {
            ForEach(viewModel.filteredSites, id: \.self) { account in
                NavigationLink {
                    AccountDetailView(
                        viewModel: AccountDetailViewModel(account: account)
                    )
                } label: {
                    AccountListCellView(
                        sitename: account.sitename,
                        username: account.username
                    )
                }
            }
            .onDelete(perform: viewModel.deleteAccount)
        }
        .scrollDismissesKeyboard(.immediately)
        .safeAreaInset(edge: .bottom) {
            AccountFootView()
        }
        .listStyle(.plain)
        .navigationTitle(String(localized: "account"))        
        .onChange(of: accounts) { _, _ in
            viewModel.fetchAccounts()
        }
    }
}

#Preview {
    AccountListView()
}
