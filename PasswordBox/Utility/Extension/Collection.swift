//
//  Collection.swift
//  PasswordBox
//
//  Created by 이민호 on 9/18/25.
//

import Foundation

extension Collection where Element: Searchable {
    func filtered(type: AccountFilterType = .sitename, query: String) -> [Element] {
        guard !query.isEmpty else { return Array(self) }
        return filter { $0.matches(by: type, query) }
    }
}
