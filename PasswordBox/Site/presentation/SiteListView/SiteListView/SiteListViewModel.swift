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
    @Injected var siteService: SiteService    
    @Published var sites: [Site] = []
    var cancellabels: Set<AnyCancellable> = []
            
    func setSites(_ sites: [Site]) {
        self.sites = sites.sorted{ $0.siteName < $1.siteName }
    }
    
    func deleteSite(offset: IndexSet) {
        for index in offset {
            let siteIdToDelete = sites[index].id
            siteService.delete(siteIdToDelete)
        }
    }
    
    func fetchSites() {
        self.sites = siteService.fetchAll()
    }
}
