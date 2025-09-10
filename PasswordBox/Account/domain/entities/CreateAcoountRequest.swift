//
//  CreateAcoountRequest.swift
//  PasswordBox
//
//  Created by 이민호 on 9/9/25.
//

import Foundation

struct CreateAccountRequest{
    let sitename: String
    let username: String
    let password: String
    let pin: String?
    let memo: String?
}
