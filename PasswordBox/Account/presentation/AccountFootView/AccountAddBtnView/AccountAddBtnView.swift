//
//  SiteAddBtnView.swift
//  PasswordBox
//
//  Created by 이민호 on 9/2/25.
//

import SwiftUI

struct AccountAddBtnView: View {
    @StateObject var viewModel = AccountAddBtnViewModel()
    @State private var showDialog = false
    
    var body: some View {
        if viewModel.type == .normal {
            Button {
                showDialog = true
            } label: {
                IconBgCircleBtnStyle(image: "plus")
            }
            .confirmationDialog(
                String(localized: "addAccount.prompt"),
                isPresented: $showDialog,
                titleVisibility: .visible
            ) {
                Button {
                    viewModel.toggleIsShowingAccountAddSheet()
                } label: {
                    Text(String(localized: "addAccount.method.idPassword"))
                    
                }
                .buttonStyle(.plain)
                .foregroundStyle(.blue)
                
                                
                Button {
                    viewModel.toggleIsShowingSocialAccountAddSheet()
                } label: {
                    Text(String(localized: "addAccount.method.social"))
                        .foregroundStyle(.blue)
                }
                
                Button(String(localized: "cancel"), role: .cancel) {}
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
