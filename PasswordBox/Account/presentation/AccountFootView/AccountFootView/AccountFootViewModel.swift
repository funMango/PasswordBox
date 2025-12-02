//
//  AccountFooterViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 9/3/25.
//

import SwiftUI
import Foundation
import Resolver
import Combine

class AccountFootViewModel: ObservableObject {
    
    @Published var searchTypeManager: SearchTypeManager = Resolver.resolve()
    var cancellables: Set<AnyCancellable> = []
    
    
        
}

