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
    @StateObject var router: Router = Resolver.resolve()
    
    var body: some View {
        List {
            switch viewModel.type {
            case .normal:
                AccountBrowseView()
            case .search:
                AccountSearchView()
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
                AccountListToolbarTitleView()
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
    }
}


