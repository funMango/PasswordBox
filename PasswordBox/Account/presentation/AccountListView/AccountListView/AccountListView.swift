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
    
    var body: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
        case .list, .search:
            AccountListOrSearchView(viewModel: viewModel)
        case .error, .cloudError:
            Text("⚠️ Error")
        }
    }
}

struct AccountListOrSearchView: View {
    @ObservedObject var viewModel: AccountListViewModel
    @StateObject var router: Router = Resolver.resolve()
    @State var showToolbarTitle: Bool = false
    @Query var accounts: [AccountDTO]
    @Query var socialAccounts: [SocialAccountDTO]
    
    var body: some View {
        List {
            if viewModel.state == .list {
                AccountListTitleView(showToolbarTitle: $showToolbarTitle)
            }
            
            AccountListContent(viewModel: viewModel) { wrapper in
                router.push(.account(wrapper))
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "line.3.horizontal")
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text(String(localized: "account"))
                    .font(.headline)
                    .opacity(showToolbarTitle && viewModel.state == .list ? 1 : 0)
                    .offset(y: showToolbarTitle && viewModel.state == .list ? 0 : -4)
                    .animation(.easeInOut(duration: 0.25), value: showToolbarTitle)
            }
        }
        .toolbarBackground(.clear, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
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
        .onChange(of: accounts) { _, _ in
            viewModel.fetchAccountWrappers()
        }
        .onChange(of: socialAccounts) { _, _ in
            viewModel.fetchAccountWrappers()
        }
        .refreshable {
            viewModel.fetchAccountWrappers()
        }
    }
}

/// List안에 복잡한 계층으로 인한 오류로 분리
struct AccountListContent: View {
    @ObservedObject var viewModel: AccountListViewModel
    var onSelect: (AccountInfoWrapper) -> Void
    
    var body: some View {
        ForEach(viewModel.displayedWrappers.indices, id: \.self) { index in
            let account = viewModel.displayedWrappers[index]

            Button(action: {
                viewModel.onTapAccountCell()
                onSelect(account)
            }) {
                account.cellView
            }
            .buttonStyle(.plain)
            .listRowSeparator(index == 0 ? .hidden : .visible, edges: .top)
        }
        .onDelete { indexSet in
            viewModel.deleteAccount(offset: indexSet)
        }
    }
}

