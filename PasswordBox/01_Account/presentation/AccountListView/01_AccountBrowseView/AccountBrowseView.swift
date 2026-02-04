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
        
        AccountBrowseContentView(viewModel: viewModel) { wrapper in
            router.push(.account(wrapper))
        }
        
    }
}

struct AccountBrowseContentView: View {
    @ObservedObject var viewModel: AccountBrowseViewModel
    
    var onSelect: (AccountInfoWrapper) -> Void
    
    var body: some View {
        ForEach(viewModel.accountWrappers.indices, id: \.self) { index in
            let account = viewModel.accountWrappers[index]

            Button(action: {
                onSelect(account)
            }) {
                VStack(alignment: .leading, spacing: 0) {
                    account.cellView
                }
                .fullRowTappable()
            }
            .rowButtonStyle()
            .listRowSeparator(index == 0 ? .hidden : .visible, edges: .top)
        }
        .onDelete { indexSet in
            viewModel.deleteAccount(offset: indexSet)
        }        
    }
}



#Preview {
    AccountBrowseView()
}

