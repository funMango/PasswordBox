//
//  AccountListTitleView.swift
//  PasswordBox
//
//  Created by 이민호 on 12/9/25.
//

import SwiftUI
import Resolver
import Combine

struct AccountBrowseTitleView: View {
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    
    var body: some View {
        ListTitleStyle(text: String(localized: "account"))
            
            .onAppear() {
                controlSubject.send(.toolbarTitleDisappear)
            }
            .onDisappear() {
                controlSubject.send(.toolbarTitleAppear)
            }            
    }
}

#Preview {
    AccountBrowseTitleView()
}
