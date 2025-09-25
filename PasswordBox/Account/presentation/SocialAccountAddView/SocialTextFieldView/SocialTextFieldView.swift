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
            AccountListCellView(
                sitename: viewModel.account?.sitename ?? "",
                username: viewModel.account?.username ?? ""
            )
            .onTapGesture {
                viewModel.sendMessage()
            }
        }
    }
}

#Preview {
    SocialTextFieldView()
}
