//
//  SocialAccountDTO.swift
//  PasswordBox
//
//  Created by 이민호 on 9/16/25.
//

import Foundation

struct SocialAccountDTO {
    let id: String
    let accountId: String   // 외래키(FK)
    let sitename: String    // 🔐 암호문
    let username: String?   // 🔐 암호문(옵션)
}
