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
        NavigationStack {
            List {
                Section("\(String(localized: "account")) *") {
                    TextField(String(localized: "name"), text: $viewModel.name)
                    TextField(String(localized: "password"), text: $viewModel.password)
                }
                
                Section {
                    TextField(String(localized: "pin"), text: $viewModel.pin)
                }
                
                
                TextField(String(localized: "memo"), text: $viewModel.memo, axis: .vertical)
                    .lineLimit(10, reservesSpace: true)
            }
            .navigationTitle(String(localized: "addPassword"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text(String(localized: "cancel"))
                        .foregroundStyle(.red)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Text(String(localized: "save"))
                            .foregroundStyle(.blue)
                    }
                    .disabled(viewModel.name.isEmpty)
                }
            }
        }
    }
}

#Preview {
    PasswordAddView()
}
