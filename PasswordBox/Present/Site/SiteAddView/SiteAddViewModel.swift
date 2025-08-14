//
//  SiteAddViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 8/12/25.
//

import Foundation
import Resolver
import Combine

class SiteAddViewModel: ObservableObject {
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    @Injected var siteService: SiteService
    @Published var siteName: String = ""
    @Published var siteURL: String = ""
    
    func deactivatePage() {
        reset()
        controlSubject.send(.toggleIsShowingSiteAddSheet)
    }
    
    func saveSite() {
        let site = Site(
            siteName: siteName,
            siteURL: siteURL
        )
        
        siteService.save(site)
        deactivatePage()
    }
    
    private func reset() {
        self.siteName = ""
        self.siteURL = ""
    }
}
