//
//  SiteDetailViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 8/18/25.
//

import Foundation

class SiteDetailViewModel: ObservableObject {
    @Published var site: Account
    @Published var isShowingPasswordAddSheet: Bool = false
    
    init(site: Account) {
        self.site = site
    }
    
    func toggleSheet() {
        isShowingPasswordAddSheet.toggle()
    }
}
