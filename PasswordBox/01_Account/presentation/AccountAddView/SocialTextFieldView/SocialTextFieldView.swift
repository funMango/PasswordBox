//
//  SocialTextFieldView.swift
//  PasswordBox
//
//  Created by 이민호 on 9/20/25.
//

import SwiftUI

struct SocialTextFieldView: View {
    @StateObject var viewModel = SocialTextFieldViewModel()
    
    var body: some View {
        if viewModel.account == nil {
            SearchTextFieldView(
                text: $viewModel.sitename,
                placeholder: "searchSiteOrAccount",
                onChange: { focusState in
                    if focusState {
                        viewModel.sendMessage()
                    }
                }
            )
        } else {
            if let account = viewModel.account {
                let fallback = viewModel.fallbackSitename(for: account)
                let usesFallback = account.username.isEmpty && fallback != nil
                AccountListCellView(
                    title: account.sitename,
                    subTitle: account.username.isEmpty ? (fallback ?? "") : account.username,
                    showsLinkIcon: usesFallback
                )
                .onTapGesture {
                    viewModel.sendMessage()
                }
            }
        }
    }
}

#Preview {
    SocialTextFieldView()
}
