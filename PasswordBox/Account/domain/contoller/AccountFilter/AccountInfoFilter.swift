//
//  AccountFilterable.swift
//  PasswordBox
//
//  Created by 이민호 on 10/2/25.
//

import Foundation

protocol AccountInfoFilter {
    func filtering(accounts: [AccountInfoWrapper], query: String, excluded: String?) -> [AccountInfoWrapper]
}
