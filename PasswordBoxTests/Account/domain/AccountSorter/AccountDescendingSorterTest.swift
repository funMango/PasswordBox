//
//  AccountDescendingSorterTest.swift
//  PasswordBoxTests
//
//  Created by 이민호 on 10/13/25.
//

import XCTest
@testable import PasswordBox

final class AccountDescendingSorterTest: XCTestCase {
    let sorter = AccountDescendingSorter()
    var commonData: [AccountInfoWrapper] = []

    override func setUpWithError() throws {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        commonData = [
            .account(Account(
                id: "1",
                sitename: "Apple",
                username: "alice",
                password: "pw1",
                createDate: formatter.date(from: "2024/05/01")!,
                updateDate: formatter.date(from: "2025/01/01")!
            )),
            .account(Account(
                id: "2",
                sitename: "Google",
                username: "bob",
                password: "pw2",
                createDate: formatter.date(from: "2023/07/01")!,
                updateDate: formatter.date(from: "2025/06/01")!
            )),
            .social(SocialAccount(
                id: "3",
                sitename: "Naver",
                socialSitename: "naver",
                username: "cathy",
                createDate: formatter.date(from: "2022/03/01")!,
                updateDate: formatter.date(from: "2024/08/01")!
            ))
        ]
    }

    func testSortByTitle() {
        let expected = ["Naver", "Google", "Apple"]
        let result = sorter
            .sort(accounts: commonData, by: .title)
            .map { $0.sitename }
        
        XCTAssertEqual(result, expected)
    }
    
    func testSortByCreateDate() {
        let expected = ["Apple", "Google", "Naver"]
        let result = sorter
            .sort(accounts: commonData, by: .createDate)
            .map { $0.sitename }
        
        XCTAssertEqual(result, expected)
    }
    
    func testSortByUpdateDate() {
        let expected = ["Google", "Apple", "Naver"]
        let result = sorter
            .sort(accounts: commonData, by: .updateDate)
            .map { $0.sitename }
        
        XCTAssertEqual(result, expected)
    }
}
