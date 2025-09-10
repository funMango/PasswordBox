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
        if viewModel.isSearchBarActive {
            Button {
                hideKeyboard()                
            } label: {
                IconBgCircleBtnStyle(image: "xmark")
            }
        } else {
            Button {
                viewModel.toggleIsShowingSiteAddSheet()
            } label: {
                IconBgCircleBtnStyle(image: "plus")
            }
        }
    }
}

#Preview {
    AccountAddBtnView()
}
