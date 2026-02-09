//
//  AccountWrappersFetchView.swift
//  PasswordBox
//
//  Created by 이민호 on 12/13/25.
//

import SwiftUI
import SwiftData

struct AccountWrappersFetchView: View {
    @StateObject var viewModel = AccountWrappersFetchViewModel()
    @Query var accounts: [AccountDTO]
    @Query var user: [UserDTO]
    
    var body: some View {
        Color.clear
            .frame(width: 1, height: 1)
            .onAppear {
                viewModel.pushDefaultAccount(accounts)
                viewModel.pushUser(user)
            }
            .onChange(of: accounts) { _, newValue in
                viewModel.pushDefaultAccount(newValue)
            }
            .onChange(of: user) { _, newValue in
                viewModel.pushUser(newValue)
            }
    }
}

#Preview {
    AccountWrappersFetchView()
}
