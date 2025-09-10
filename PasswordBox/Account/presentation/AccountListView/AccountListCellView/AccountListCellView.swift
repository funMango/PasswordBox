//
//  SiteListCellView.swift
//  PasswordBox
//
//  Created by 이민호 on 8/11/25.
//

import SwiftUI

struct AccountListCellView: View {
    @StateObject var viewModel: AccountListCellViewModel
    
    init(viewModel: AccountListCellViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(viewModel.account.sitename)
                    .fontWeight(.regular)
                
                Text(verbatim: "example@example.com")
                    .foregroundStyle(Color.gray)
                    .font(.caption)
            }
            
            Spacer()
        }
        .frame(height: 40)
    }
}

#Preview {
    AccountListCellView(
        viewModel: AccountListCellViewModel(
            site: Account(sitename: "Amazone", username: "", password: "")
        )
    )
}
