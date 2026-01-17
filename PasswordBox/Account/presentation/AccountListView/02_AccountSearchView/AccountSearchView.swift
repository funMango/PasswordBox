//
//  AccountSearchView.swift
//  PasswordBox
//
//  Created by 이민호 on 12/10/25.
//

import SwiftUI

struct AccountSearchView: View {
    @StateObject var viewModel = AccountSearchViewModel()
    
    var body: some View {        
        Section(header: Text("최근 검색 계정")) {
            ForEach(viewModel.accountWrappers, id: \.self) { wrapper in
                wrapper.cellView
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    AccountSearchView()
}
