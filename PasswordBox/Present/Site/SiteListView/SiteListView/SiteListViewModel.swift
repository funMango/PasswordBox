//
//  SiteListViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 8/14/25.
//

import Foundation
import Resolver
import Combine

class SiteListViewModel: ObservableObject {
    @Published var sites: [Site] = []
    
    func setSites(_ sites: [Site]) {
        self.sites = sites
    }
}
