//
//  CreateSocialAccountRequest.swift
//  PasswordBox
//
//  Created by 이민호 on 9/25/25.
//

import Foundation

struct CreateSocialAccountRequest {
    let sitename: String
    let socialSitename: String
    let username: String?
    let accountId: String?
}
