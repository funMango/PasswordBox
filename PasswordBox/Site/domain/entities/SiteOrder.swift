//
//  SiteOrder.swift
//  PasswordBox
//
//  Created by 이민호 on 9/4/25.
//

import Foundation

protocol SortOption {
    var type: String { get }
    var image: String { get }
}

enum SiteOrderBy: String, SortOption {
    case title, createDate, updateDate
    
    var type: String {
        switch self {
        case .title: return "title"
        case .createDate: return "createDate"
        case .updateDate: return "updateDate"
        }
    }
    
    var image: String {
        switch self {
        case .title: return "textformat"
        case .createDate: return "calendar"
        case .updateDate: return "clock"
        }
    }
}

enum SiteOrder: String, SortOption {
    case ascending, descending
    
    var type: String {
        switch self {
        case .ascending: return "Ascending"
        case .descending: return "Descending"
        }
    }
    
    var image: String {
        switch self {
        case .ascending: return "arrow.up"
        case .descending: return "arrow.down"
        }
    }
}
