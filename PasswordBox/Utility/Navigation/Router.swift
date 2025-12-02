//
//  Router.swift
//  PasswordBox
//
//  Created by 이민호 on 12/1/25.
//

import Foundation
import SwiftUI
import Combine

final class Router: ObservableObject {
    @Published var path: [Route] = []
        
    func push(_ route: Route) {        
        path.append(route)
    }
    
    func pop() {
        _ = path.popLast()
    }
    
    func reset() {
        path.removeAll()
    }
}
