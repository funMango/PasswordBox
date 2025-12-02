//
//  SiteListView.swift
//  PasswordBox
//
//  Created by 이민호 on 8/11/25.
//

import SwiftUI
import Resolver
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
                /// tpye 추론이 오래걸려서 AccountListContent에서는 수행하지 못한다.
                AccountListContent(viewModel: viewModel) { wrapper in
                    viewModel.router.push(.account(wrapper))
                }
            }
        }
        .navigationDestination(for: Route.self) { route in
            switch route {
            case .account(let wrapper):
                wrapper.destinationView
            }
        }
        .safeAreaInset(edge: .bottom) {
            AccountFootView()
        }
        .scrollDismissesKeyboard(.immediately)
        .listStyle(.plain)
        .navigationTitle(viewModel.searchTypeManager.type == .normal ?
                         String(localized: "account") :
                         String(localized: "search") )
        
        .onChange(of: accounts) { _, _ in
            Task { await viewModel.fetchAccountWrappers() }
        }
        .onChange(of: socialAccounts) { _, _ in
            Task { await viewModel.fetchAccountWrappers() }
        }
        .refreshable {
            Task { await viewModel.fetchAccountWrappers() }
        }
    }
}

/// List안에 복잡한 계층으로 인한 오류로 분리
struct AccountListContent: View {
    @ObservedObject var viewModel: AccountListViewModel
    var onSelect: (AccountInfoWrapper) -> Void

    var body: some View {
        ForEach(viewModel.displayedWrappers, id: \.self) { account in
            Button {
                viewModel.onTapAccountCell()
                onSelect(account)
            } label: {
                account.cellView
            }
            .buttonStyle(.plain)
        }
        .onDelete { indexSet in
            viewModel.deleteAccount(offset: indexSet)
        }
    }
}
