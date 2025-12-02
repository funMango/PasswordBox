//
//  AccountFooterVIew.swift
//  PasswordBox
//
//  Created by 이민호 on 9/1/25.
//

import SwiftUI
import Resolver

struct AccountFootView: View {
    @State var searchTypeManager: SearchTypeManager = Resolver.resolve()
    
    var body: some View {
        HStack(spacing: 10) {
            if searchTypeManager.type == .normal {
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
