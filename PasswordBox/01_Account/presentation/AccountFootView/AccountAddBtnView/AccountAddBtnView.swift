//
//  SiteAddBtnView.swift
//  PasswordBox
//
//  Created by 이민호 on 9/2/25.
//

import SwiftUI

struct AccountAddBtnView: View {
    @StateObject var viewModel = AccountAddBtnViewModel()
    
    var body: some View {
        if viewModel.type == .normal {
            Button {
                viewModel.showAccountAddSheet()
            } label: {
                Label("Plus", systemImage: "plus")
                    .glassIconLabel(size: 50)
            }
            .glassButtonStyle()
            
        } else {
            Button {
                hideKeyboard()
                viewModel.tappedCloseButton()
            } label: {
                Label("Cancel", systemImage: "xmark")
                    .glassIconLabel(size: 50)
            }
            .glassButtonStyle()
        }
    }
}

#Preview {
    AccountAddBtnView()
}
