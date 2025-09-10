//
//  SiteListViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 8/14/25.
//

import Foundation
import Resolver
import Combine

class SiteListViewModel: ObservableObject, AccountMessageBindable {
    @Injected var siteService: AccountService
    @Injected var accountSubject: PassthroughSubject<AccountMessage, Never>
    @Published var sites: [Account] = []
    @Published var searchText: String = ""
    var cancellables: Set<AnyCancellable> = []
    
    var filteredSites: [Account] {
        guard !searchText.isEmpty else {
            return sites
        }
        
        return sites.filter { site in
            site.sitename.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    init() {
        setupSiteMessageBinding()
    }
    
    func fetchSites() {
        self.sites = siteService.fetchAll()
    }
                    
    func deleteSite(offset: IndexSet) {
        for index in offset {
            let siteIdToDelete = sites[index].id
            siteService.delete(siteIdToDelete)
        }
    }
    
    func setupSiteMessageBinding() {
        bindAccountMessage{ message in
            switch message {
            case .changeSearchText(let newText):
                DispatchQueue.main.async {
                    self.searchText = newText
                }
            default:
                return
            }
            
        }
    }
}
