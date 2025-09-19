//
//  ListFetchingService.swift
//  PasswordBox
//
//  Created by 이민호 on 9/18/25.
//

import Foundation

protocol ListFetchingService {
    associatedtype Item
    func fetchAll() -> [Item]
}
