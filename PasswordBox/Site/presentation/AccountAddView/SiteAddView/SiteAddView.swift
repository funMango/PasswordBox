//
//  SiteAddView.swift
//  PasswordBox
//
//  Created by 이민호 on 9/8/25.
//

import SwiftUI

struct SiteAddView: View {
    @StateObject var viewModel = SiteAddViewModel()
    
    var body: some View {
        List {
            Section {
                TextField(
                    String(localized: "searchOrCreateSite"),
                    text: $viewModel.text
                )
                .onAppear {
                    UITextField.appearance().clearButtonMode = .whileEditing
                }
            }
                        
            if viewModel.filteredAccounts.isEmpty && !viewModel.text.isEmpty {
                Section {
                    Button {
                        viewModel.createSite()
                    } label: {
                        let fmt = NSLocalizedString("createSite", comment: "Create {site}")
                        Text(String(format: fmt, locale: .current, viewModel.text))
                    }
                }
            } else {
                Section {
                    ForEach(viewModel.filteredAccounts, id: \.self) { account in
                        Button {
                            
                        } label: {
                            Text(account.siteName)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SiteAddView()
}
