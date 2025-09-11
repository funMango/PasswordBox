//
//  ContentView.swift
//  PasswordBox
//
//  Created by 이민호 on 8/10/25.
//

import SwiftUI

struct AccountView: View {
    @StateObject var viewModel = AccountViewModel()
    
    var body: some View {
        NavigationStack {
            AccountListView()            
        }
        .sheet(isPresented: $viewModel.isShowingSiteAddSheet) {
            AccountAddView()
        }
    }
}

#Preview {
    AccountView()
}
