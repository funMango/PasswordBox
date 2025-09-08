//
//  PasswordAddView.swift
//  PasswordBox
//
//  Created by 이민호 on 8/18/25.
//

import SwiftUI

struct PasswordAddView: View {
    @StateObject var viewModel = PasswordAddViewModel()
    
    var body: some View {
        Section {
            TextField(String(localized: "username"), text: $viewModel.name)
            TextField(String(localized: "password"), text: $viewModel.password)
        }
        
        Section {
            TextField(String(localized: "pin"), text: $viewModel.pin)
        }
        
        
        TextField(String(localized: "memo"), text: $viewModel.memo, axis: .vertical)
            .lineLimit(5, reservesSpace: true)
    }
}

#Preview {
    PasswordAddView()
}
