//
//  SiteListCellViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 8/11/25.
//

import Foundation

class AccountListCellViewModel: ObservableObject {
    @Published var account: Account
    
    init(site: Account){
        self.account = site
    }
}
