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
            .onChange(of: isSearchBarFocused) { _ , isFocused in
                viewModel.sendFocuseState(by: isFocused)
            }
    }
}

#Preview {
    AccountSearchBarView()
}
