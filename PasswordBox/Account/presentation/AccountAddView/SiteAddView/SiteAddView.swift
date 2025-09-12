//
//  SiteAddView.swift
//  PasswordBox
//
//  Created by 이민호 on 9/8/25.
//

import SwiftUI

struct SiteAddView: View {
    @StateObject var viewModel = SiteAddViewModel()
    @FocusState private var isFocused: Bool
    
    var body: some View {
        List {
            Section {
                TextField(
                    String(localized: "searchOrCreateSite"),
                    text: $viewModel.text
                )
                .textFieldOptions()
                .focused($isFocused)
                .onAppear {
                    UITextField.appearance().clearButtonMode = .whileEditing
                    isFocused = true                    
                }
                .onSubmit {
                    viewModel.updateSite()
                }
            }
                        
            if viewModel.filteredAccounts.isEmpty && !viewModel.text.isEmpty {
                Section {
                    Button {
                        viewModel.updateSite()
                    } label: {
                        let fmt = NSLocalizedString("createSite", comment: "Create {site}")
                        Text(String(format: fmt, locale: .current, viewModel.text))
                    }
                }
            } else {
                Section {
                    ForEach(viewModel.filteredAccounts, id: \.self) { account in
                        Button {
                            viewModel.setSite(from: account.sitename)
                        } label: {
                            Text(account.sitename)
                        }
                    }
                }
            }
        }
        .scrollDismissesKeyboard(.immediately)        
    }
}

#Preview {
    SiteAddView()
}
