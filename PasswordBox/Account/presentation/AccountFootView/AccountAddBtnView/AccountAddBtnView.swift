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
        if viewModel.isSearchBarActive {
            Button {
                hideKeyboard()
            } label: {
                IconBgCircleBtnStyle(image: "xmark")
            }
        } else {
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
                    viewModel.toggleIsShowingSiteAddSheet()
                } label: {
                    Text(String(localized: "addAccount.method.idPassword"))
                        
                }
                .buttonStyle(.plain)
                .foregroundStyle(.blue)
                
                
                Button {
                    
                } label: {
                    Text(String(localized: "addAccount.method.social"))
                        .foregroundStyle(.blue)
                }
                                                       
                Button(String(localized: "cancel"), role: .cancel) {}
            }
        }
    }
}

#Preview {
    AccountAddBtnView()
}
