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
                viewModel.toggleIsShowingAccountAddSheet()
            } label: {
                IconBgCircleBtnStyle(image: "plus")
            }
        } else {
            Button {
                hideKeyboard()
                viewModel.tappedCloseButton()
            } label: {
                IconBgCircleBtnStyle(image: "xmark")
            }
        }
    }
}

#Preview {
    AccountAddBtnView()
}
