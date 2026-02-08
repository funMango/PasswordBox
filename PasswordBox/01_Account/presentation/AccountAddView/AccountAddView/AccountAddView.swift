//
//  SiteAddView.swift
//  PasswordBox
//
//  Created by 이민호 on 8/11/25.
//

import SwiftUI

struct AccountAddView: View {
    @StateObject var viewModel = AccountAddViewModel()
    @FocusState private var focusedField: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    AccountCredentialsAddView()
                }
                .scrollDismissesKeyboard(.immediately)
            }            
            .sheet(isPresented: $viewModel.isSiteSearchActive) {
                SiteAddView()
            }
            .sheet(isPresented: $viewModel.isSocialSearchActive) {
                SocialAddView()
            }            
            .navigationTitle(String(localized: "addAccount"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.saveAccount()
                    } label: {
                        Text(String(localized: "save"))
                            .foregroundStyle(viewModel.canSave ? .blue : .gray)
                    }
                    .disabled(!viewModel.canSave)
                }
            }
        }
    }
}

#Preview {
    AccountAddView()
}
