//
//  SiteService.swift
//  PasswordBox
//
//  Created by 이민호 on 8/14/25.
//

import Foundation
import Resolver

protocol SiteService {
    func save(name: String, url: String?)
    func fetchAll() -> [Site] 
    func delete(_ siteId: String)
}

class DefaultSiteService: SiteService {
    @Injected var repository: SiteRepository
    
    func save(name: String, url: String?) {
        let site = Site(siteName: name, siteURL: url, order: 0)
        repository.save(site)
    }
    
    func fetchAll() -> [Site] {
        repository.fetch()
    }
    
    func delete(_ siteId: String) {
        repository.delete(siteId: siteId)
    }
}
