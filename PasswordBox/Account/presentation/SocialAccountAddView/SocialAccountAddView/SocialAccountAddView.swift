//
//  SocialAccountAddView.swift
//  PasswordBox
//
//  Created by 이민호 on 9/15/25.
//

import SwiftUI

struct SocialAccountAddView: View {
    @StateObject var viewModel = SocialAccountAddViewModel()
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationStack {
            List {
                Section(String(localized: "siteName")) {
                    SiteTextFieldView()
                }
                
                Section(String(localized: "linkedAccount")) {
                    SocialTextFieldView()
                }
            }
            .sheet(isPresented: $viewModel.isSiteSearchActive) {
                SiteAddView()
            }
            .sheet(isPresented: $viewModel.isSocialSearchActive) {
                SocialAddView()
            }
            .navigationTitle(String(localized: "addAccount.social.title"))
            .navigationBarTitleDisplayMode(.inline)
            .scrollDismissesKeyboard(.immediately)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.save()
                    } label: {
                        Text(String(localized: "save"))
                    }
                    .disabled(!viewModel.canSave)
                }
            }
            .onChange(of: viewModel.canSave) { _, newValue in
                print("canSave: \(newValue)")
            }
        }
    }
}

#Preview {
    SocialAccountAddView()
}
    
