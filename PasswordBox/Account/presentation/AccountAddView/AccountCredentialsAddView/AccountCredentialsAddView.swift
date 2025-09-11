//
//  PasswordAddView.swift
//  PasswordBox
//
//  Created by 이민호 on 8/18/25.
//

import SwiftUI

struct AccountCredentialsAddView: View {
    @StateObject var viewModel = AccountCredentialsAddViewModel()
    
    var body: some View {        
        Section {
            TextField(
                String(localized: "username"),
                text: $viewModel.credentials.username
            )
            .textFieldOptions()
            
            PasswordField(password: $viewModel.credentials.password)
        }
        
        Section {
            PasswordField(password: $viewModel.credentials.pin.bound, type: .pin)
        }
            
        Section {
            TextField(
                String(localized: "memo"),
                text: $viewModel.credentials.memo.bound,
                axis: .vertical
            )
            .textFieldOptions()
            .lineLimit(5, reservesSpace: true)
        }
    }
}

#Preview {
    AccountCredentialsAddView()
}
