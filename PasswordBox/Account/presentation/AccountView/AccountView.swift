//
//  ContentView.swift
//  PasswordBox
//
//  Created by 이민호 on 8/10/25.
//

import SwiftUI
import Resolver

struct AccountView: View {
    @StateObject var viewModel = AccountViewModel()
    @StateObject var router: Router = Resolver.resolve()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            AccountListView()
        }
        .sheet(isPresented: $viewModel.isShowingAccountAddSheet) {
            AccountAddView()
        }
        .sheet(isPresented: $viewModel.isShowingSocialAccountAddSheet) {
            SocialAccountAddView()
        }
        
    }
}

#Preview {
    AccountView()
}
