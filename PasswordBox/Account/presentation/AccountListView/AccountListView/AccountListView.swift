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
            if viewModel.isLoading {
                ProgressView()
            } else {
                AccountListContent(viewModel: viewModel)
            }
        }
        .scrollDismissesKeyboard(.immediately)
        .safeAreaInset(edge: .bottom) {
            AccountFootView()
        }
        .listStyle(.plain)
        .navigationTitle(String(localized: "account"))
        .onChange(of: accounts) { _, _ in
            Task { await viewModel.fetchAccountWrappers() }
        }
        .onChange(of: socialAccounts) { _, _ in            
            Task { await viewModel.fetchAccountWrappers() }
        }
        .task {
            await viewModel.fetchAccountWrappers()
        }
        .refreshable {
            Task {
                await viewModel.fetchAccountWrappers()
            }
        }
    }
}

/// List안에 복잡한 계층으로 인한 오류로 분리
struct AccountListContent: View {
    @ObservedObject var viewModel: AccountListViewModel

    var body: some View {
        ForEach(viewModel.accountWrappers, id: \.self) { wrappers in
            NavigationLink {
                wrappers.destinationView
            } label: {
                wrappers.cellView
            }
        }
        .onDelete { indexSet in
            viewModel.deleteAccount(offset: indexSet)
        }
    }
}

#Preview {
    AccountListView()
}
