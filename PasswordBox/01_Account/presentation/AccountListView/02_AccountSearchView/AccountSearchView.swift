//
//  AccountSearchView.swift
//  PasswordBox
//
//  Created by 이민호 on 12/10/25.
//

import SwiftUI
import Resolver

struct AccountSearchView: View {
    @StateObject var viewModel = AccountSearchViewModel()
    @StateObject var router: Router = Resolver.resolve()
    
    var body: some View {        
        Section(header: viewModel.query.isEmpty ? Text(String(localized: "recentlyUpdatedAccounts")) : Text("")) {
            ForEach(viewModel.displayWrappers.indices, id: \.self) { index in
                let account = viewModel.displayWrappers[index]
                
                Button {
                    router.push(.account(account))
                } label: {
                    Group {
                        if viewModel.query.isEmpty {
                            let subtitle = viewModel.displaySubtitle(for: account)
                            AccountListCellView(
                                title: account.sitename,
                                subTitle: subtitle.text,
                                showsLinkIcon: subtitle.usesFallback
                            )
                        } else {
                            let subtitle = viewModel.displaySubtitle(for: account)
                            AccountListHighlightCellView(
                                sitename: account.sitename,
                                username: subtitle.text,
                                query: viewModel.query,
                                showsLinkIcon: subtitle.usesFallback
                            )
                        }
                    }
                    .fullRowTappable()
                }
                .rowButtonStyle()
                .listRowSeparator(index == 0 ? .hidden : .visible, edges: .top)
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    AccountSearchView()
}
