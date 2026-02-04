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
                let wrapper = viewModel.displayWrappers[index]
                
                Button {
                    router.push(.account(wrapper))
                } label: {
                    Group {
                        if viewModel.query.isEmpty {
                            wrapper.cellView
                        } else {
                            wrapper.cellHighlightedView(query: viewModel.query)
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
