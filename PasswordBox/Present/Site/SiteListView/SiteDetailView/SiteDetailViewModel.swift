//
//  SiteDetailViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 8/18/25.
//

import Foundation

class SiteDetailViewModel: ObservableObject {
    @Published var site: Site
    
    init(site: Site) {
        self.site = site
    }        
}
