//
//  SiteDetailView.swift
//  PasswordBox
//
//  Created by 이민호 on 8/18/25.
//

import SwiftUI

struct AccountDetailView: View {
    @ObservedObject var viewModel: AccountDetailViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            List {
                ForEach(1...50, id: \.self) { value in
                    Text("비밀번호")
                }
            }
            
            Button {
                viewModel.toggleSheet()
            } label: {
                Text("비밀번호 추가하기")
                    .padding()
                    .fontWeight(.medium)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle(viewModel.account.sitename)
        .sheet(isPresented: $viewModel.isShowingPasswordAddSheet) {
            AccountCredentialsAddView()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Text("편집")
                        .foregroundStyle(.gray)
                }
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Icon(
                        name: "chevron.left",
                        size: .small
                    )
                }
            }
        }
    }
}

#Preview {
    let site = Account(sitename: "Google", username: "", password: "")
    AccountDetailView(viewModel: AccountDetailViewModel(account: site))
}
