//
//  SiteSearchViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 8/31/25.
//

import Foundation
import Resolver

class SiteSearchViewModel: ObservableObject {
    @Injected var siteService: SiteService
    @Published var searchText: String = ""
    @Published var sites: [Site] = []
    
    var filterdSites: [Site] {
        if searchText.isEmpty {
            return sites
        } else {
            return sites.filter { $0.siteName.localizedStandardContains(searchText) }
        }
    }
    
    
    func fetchSites() {
        self.sites = siteService.fetchAll()
    }                
}
