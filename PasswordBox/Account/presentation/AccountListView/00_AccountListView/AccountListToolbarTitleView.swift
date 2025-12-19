//
//  AccountListToolbarTitleView.swift
//  PasswordBox
//
//  Created by 이민호 on 12/10/25.
//

import SwiftUI

struct AccountListToolbarTitleView: View {
    @StateObject var viewModel = AccountListToolbarTitleViewModel()
    
    var body: some View {
        Text(viewModel.title)
            .font(.headline)
            .opacity(viewModel.showToolbarTitle && viewModel.state == .normal ? 1 : 0)
            .offset(y: viewModel.showToolbarTitle && viewModel.state == .normal ? 0 : -4)
            .animation(.easeInOut(duration: 0.25), value: viewModel.showToolbarTitle)
    }
}

//#Preview {
//    AccountListToolbarTitleView()
//}
