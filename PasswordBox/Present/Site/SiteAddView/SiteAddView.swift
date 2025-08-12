//
//  SiteAddView.swift
//  PasswordBox
//
//  Created by 이민호 on 8/11/25.
//

import SwiftUI

struct SiteAddView: View {
    @StateObject var viewModel = SiteAddViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("\(String(localized: "name")) *")) {
                    TextField(String(localized: "siteName"), text: $viewModel.siteName)
                }
                                        
                Section(header: Text("URL")) {
                    TextField("\("www.passwordbox.com")", text: $viewModel.siteURL)
                }
            }
            .navigationTitle(String(localized: "addSite"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        viewModel.deactivatePage()
                    } label: {
                        Text(String(localized: "cancel"))
                            .foregroundStyle(.red)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Text(String(localized: "save"))
                    }
                }
            }
        }
    }
}

#Preview {
    SiteAddView()
}
