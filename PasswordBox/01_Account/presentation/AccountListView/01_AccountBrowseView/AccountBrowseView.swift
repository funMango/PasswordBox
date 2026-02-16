//
//  AccountBrowseView.swift
//  PasswordBox
//
//  Created by 이민호 on 12/10/25.
//

import SwiftUI
import SwiftData
import Resolver

struct AccountBrowseView: View {
    @StateObject var viewModel = AccountBrowseViewModel()
    @StateObject var router: Router = Resolver.resolve()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            AccountBrowseTitleView()
            IcloudStateView()
            AccountWrappersFetchView()
        }
        .listRowSeparator(.hidden)
        
        AccountBrowseContentView(viewModel: viewModel) { account in
            router.push(.account(account))
        }
        
    }
}

struct AccountBrowseContentView: View {
    @ObservedObject var viewModel: AccountBrowseViewModel
    
    var onSelect: (Account) -> Void
    
    var body: some View {
        ForEach(viewModel.accountWrappers, id: \.id) { account in

            Button(action: {
                onSelect(account)
            }) {
                VStack(alignment: .leading, spacing: 0) {
                    let subtitle = viewModel.displaySubtitle(for: account)
                    AccountListCellView(
                        title: account.sitename,
                        subTitle: subtitle.text,
                        showsLinkIcon: subtitle.usesFallback
                    )
                }
                .fullRowTappable()
            }
            .rowButtonStyle()
            .listRowSeparator(account.id == viewModel.accountWrappers.first?.id ? .hidden : .visible, edges: .top)
        }
        .onDelete { indexSet in
            withAnimation(.default) {
                viewModel.deleteAccount(offset: indexSet)
            }
        }        
    }
}



#Preview {
    AccountBrowseView()
}
