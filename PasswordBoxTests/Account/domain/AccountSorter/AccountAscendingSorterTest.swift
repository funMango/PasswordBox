//
//  AccountOrderSorterTest.swift
//  PasswordBoxTests
//
//  Created by 이민호 on 10/13/25.
//

import XCTest
@testable import PasswordBox

final class AccountAscendingSorterTest: XCTestCase {
    let sorter = AccountAscendingSorter()
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

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSortByTitle() {
        let expected = ["Apple", "Google", "Naver"]
        let result = sorter
            .sort(accounts: commonData, by: .title)
            .map { $0.sitename }
        
        XCTAssertEqual(result, expected)
    }
    
    func testSortByCreateDate() {
        let expected = ["Naver", "Google", "Apple"]
        let result = sorter
            .sort(accounts: commonData, by: .createDate)
            .map { $0.sitename }
        
        XCTAssertEqual(result, expected)
    }
    
    func testSortByUpdateDate() {
        let expected = ["Naver", "Apple", "Google"]
        let result = sorter
            .sort(accounts: commonData, by: .updateDate)
            .map { $0.sitename }
        
        XCTAssertEqual(result, expected)
    }
}
