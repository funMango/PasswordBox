//
//  AccountListTitleView.swift
//  PasswordBox
//
//  Created by 이민호 on 12/9/25.
//

import SwiftUI

struct AccountListTitleView: View {
    @Binding var showToolbarTitle: Bool
    
    var body: some View {
        ListTitleStyle(text: String(localized: "account"))
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
            .onAppear() {
                withAnimation(.easeInOut(duration: 0.2)) {
                    showToolbarTitle = false
                }
            }
            .onDisappear() {
                withAnimation(.easeInOut(duration: 0.2)) {
                    showToolbarTitle = true
                }
            }
    }
}
