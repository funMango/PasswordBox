//
//  SiteOrder.swift
//  PasswordBox
//
//  Created by 이민호 on 9/4/25.
//

import Foundation
import SwiftUI

protocol AccountOption {
    var text: LocalizedStringKey { get }
    var image: String { get }
}

enum AccountOrderBy: String, CaseIterable, AccountOption {
    case updateDate, createDate, title
    
    var text: LocalizedStringKey {
        switch self {
        case .updateDate: return "updateDate"
        case .createDate: return "createDate"
        case .title: return "title"
        }
    }
    
    var image: String {
        switch self {
        case .updateDate: return "clock"
        case .createDate: return "calendar"
        case .title: return "textformat"        
        }
    }
}

enum AccountOrder: String, CaseIterable, AccountOption {
    case descending, ascending
    
    var text: LocalizedStringKey {
        switch self {
        case .descending: return "descending"
        case .ascending: return "ascending"
        }
    }
    
    var image: String {
        switch self {
        case .descending: return "arrow.up"
        case .ascending: return "arrow.down"
        }
    }        
}
