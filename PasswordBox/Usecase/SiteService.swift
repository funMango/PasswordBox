//
//  SiteService.swift
//  PasswordBox
//
//  Created by 이민호 on 8/14/25.
//

import Foundation
import Resolver

protocol SiteService {
    func save(_ site: Site)
}

class DefaultSiteService: SiteService {
    @Injected var repository: SiteRepository
    
    func save(_ site: Site) {
        site.setOrder(repository.fetch().count)
        repository.save(site)
    }        
}
