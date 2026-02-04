//
//  AccountFiltering.swift
//  PasswordBox
//
//  Created by 이민호 on 9/29/25.
//

import Foundation

protocol AccountFilter {
    func filtering(accounts: [Account], query: String, excluded: String?) -> [Account]
}
