//
//  AccountFooterVIew.swift
//  PasswordBox
//
//  Created by 이민호 on 9/1/25.
//

import SwiftUI
import Resolver

struct AccountFootView: View {
    @StateObject var viewModel = AccountFootViewModel()
    
    var body: some View {
        HStack(spacing: 10) {
            if viewModel.type == .normal {
                AccountSortView()
            }

            AccountSearchBarView()
            
            AccountAddBtnView()
        }
        .padding()
    }
}

#Preview {
    AccountFootView()
}
