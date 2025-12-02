//
//  AccountSearchView.swift
//  PasswordBox
//
//  Created by 이민호 on 11/26/25.
//

import SwiftUI

struct AccountSearchView: View {
    @StateObject var viewModel = AccountSearchViewModel()
    
    var body: some View {
        ForEach(viewModel.accountWrappers, id: \.self) { account in
            NavigationLink {
                account.destinationView
            } label: {
                account.cellView
            }
        }        
    }
}

#Preview {
    AccountSearchView()
}
