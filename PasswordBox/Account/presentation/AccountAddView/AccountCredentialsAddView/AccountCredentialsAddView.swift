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
            TextField(String(localized: "username"), text: $viewModel.credentials.username)
            TextField(String(localized: "password"), text: $viewModel.credentials.password)
        }
        
        Section {
            TextField(String(localized: "pin"), text: $viewModel.credentials.pin.bound)
        }
                
        TextField(
            String(localized: "memo"),
            text: $viewModel.credentials.memo.bound,
            axis: .vertical
        )
        .lineLimit(5, reservesSpace: true)
    }
}

#Preview {
    AccountCredentialsAddView()
}
