//
//  Collection.swift
//  PasswordBox
//
//  Created by 이민호 on 9/18/25.
//

import Foundation

extension Collection where Element: Searchable {
    func filtered(by query: String) -> [Element] {
        guard !query.isEmpty else { return Array(self) }
        return filter { $0.matches(query) }
    }
}
