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
    @Query var socialAccounts: [SocialAccountDTO]
    
    var body: some View {
        List {
            ForEach(viewModel.accountWrappers, id: \.self) { wrappers in
                NavigationLink {
                    wrappers.destinationView
                } label: {
                    wrappers.cellView
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
            viewModel.fetchAccountWrappers()
        }
        .onChange(of: socialAccounts) { _, _ in            
            viewModel.fetchAccountWrappers()
        }
    }
}

#Preview {
    AccountListView()
}
