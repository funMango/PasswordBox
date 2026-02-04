//
//  UserError.swift
//  PasswordBox
//
//  Created by 이민호 on 12/13/25.
//

import SwiftUI

enum UserError: LocalizedError {
    case userNotFound
    case updateFailed
    case fetchFailed
    
    var errorDescription: String? {
        switch self {
        case .userNotFound:
            return "⚠️ 사용자 정보를 찾을 수 없습니다."
        case .updateFailed:
            return "⚠️ 사용자 정보를 업데이트 하는데 실패하였습니다."
        case .fetchFailed:
            return "⚠️ UserDTO를 조회하는데 실패하였습니다."
        }
    }
    
    var errorMessage: LocalizedStringKey? {
        switch self {
        case .userNotFound:
            return LocalizedStringKey("userNotFound")
        default:
            return nil
        }
    }
}
