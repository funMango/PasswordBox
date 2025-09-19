//
//  Searchable.swift
//  PasswordBox
//
//  Created by 이민호 on 9/18/25.
//

import Foundation

protocol Searchable {
    func matches(_ query: String) -> Bool
}
