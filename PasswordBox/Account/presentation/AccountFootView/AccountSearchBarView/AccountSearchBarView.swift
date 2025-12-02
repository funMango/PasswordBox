//
//  SiteSearchBarView.swift
//  PasswordBox
//
//  Created by 이민호 on 9/2/25.
//

import SwiftUI

struct AccountSearchBarView: View {
    @StateObject var viewModel = AccountSearchBarViewModel()
    @FocusState var isSearchBarFocused: Bool
    
    var body: some View {
        TextField(String(localized: "search"), text: $viewModel.text)
            .searchBarStyle()
            .focused($isSearchBarFocused)
            .onChange(of: isSearchBarFocused) { _, focused in
                if focused { viewModel.searchBarTapped() }
            }
            .onReceive(viewModel.controlSubject) { message in
                switch message {
                case .focusSearchBar:
                    withAnimation(.default) {
                        if viewModel.canfocus() { isSearchBarFocused = true }
                    }
                case .deFocusSearchBar:
                    isSearchBarFocused = false
                                    
                default:
                    break
                }
            }
    }
}

#Preview {
    AccountSearchBarView()
}
