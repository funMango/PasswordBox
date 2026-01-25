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
        Section(header: Text("최근 계정")) {
            ForEach(viewModel.displayWrappers.indices, id: \.self) { index in
                let wrapper = viewModel.displayWrappers[index]
                
                Button {
                    router.push(.account(wrapper))
                } label: {
                    if viewModel.query.isEmpty {
                        wrapper.cellView
                    } else {
                        wrapper.cellHighlightedView(query: viewModel.query)
                    }                    
                }
                .buttonStyle(.plain)
                .listRowSeparator(index == 0 ? .hidden : .visible, edges: .top)
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    AccountSearchView()
}
