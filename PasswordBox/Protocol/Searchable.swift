//
//  Searchable.swift
//  PasswordBox
//
//  Created by 이민호 on 9/18/25.
//

import Foundation

protocol Searchable {
    func matches(by type: AccountFilterType, _ query: String) -> Bool
}
