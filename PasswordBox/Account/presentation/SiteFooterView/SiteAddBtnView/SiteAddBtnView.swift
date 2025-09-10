//
//  SiteAddBtnView.swift
//  PasswordBox
//
//  Created by 이민호 on 9/2/25.
//

import SwiftUI

struct SiteAddBtnView: View {
    @StateObject var viewModel = SiteAddBtnViewModel()
    
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
    SiteAddBtnView()
}
