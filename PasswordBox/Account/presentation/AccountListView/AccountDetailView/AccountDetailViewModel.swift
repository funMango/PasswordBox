//
//  SiteDetailViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 8/18/25.
//

import Foundation

class AccountDetailViewModel: ObservableObject {
    @Published var account: Account
    @Published var isShowingPasswordAddSheet: Bool = false
    
    init(account: Account) {
        self.account = account
    }
    
    func toggleSheet() {
        isShowingPasswordAddSheet.toggle()
    }
}
