//
//  SocialAccountSelectedView.swift
//  PasswordBox
//
//  Created by 이민호 on 9/16/25.
//

import SwiftUI

struct SocialAccountSelectedView: View {
    @StateObject var viewModel = SocialAccountSelectedViewModel()    
    
    var body: some View {
        if viewModel.selectedSite != nil {
            Section(String(localized: "selectedSite")) {
                HStack {
                    if let sitename = viewModel.selectedSite {
                        Text(sitename)
                    }
                    
                    Spacer()
                    
                    Button {
                        withAnimation(.easeInOut) {
                            viewModel.delteSite()
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.gray)
                    }
                }
            }
        }
        
        if viewModel.selectedAccount != nil {
            Section(String(localized: "selectedAccount")) {
                HStack {
                    if let selected = viewModel.selectedAccount {
                        AccountListCellView(
                            sitename: selected.sitename,
                            username: selected.username
                        )
                    }
                                                            
                    Spacer()
                    
                    Button {
                        withAnimation(.easeInOut) {
                            viewModel.deleteAccount()
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.gray)
                    }
                }
            }
        }
    }
}

#Preview {
    let viewModel = SocialAccountSelectedViewModel()
    viewModel.selectedSite = "Google"
    viewModel.selectedAccount = Account(
        sitename: "Amazon",
        username: "test@example.com",
        password: "1234"
    )
    
    return SocialAccountSelectedView(viewModel: viewModel)
}
