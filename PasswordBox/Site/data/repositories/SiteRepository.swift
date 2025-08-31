//
//  SiteRepository.swift
//  PasswordBox
//
//  Created by 이민호 on 8/12/25.
//

import Foundation
import Resolver
import SwiftData

protocol SiteRepository {
    func save(_ site: Site)
    func fetch() -> [Site]
    func delete(siteId: String)
}

class DefaultSiteRepository: SiteRepository {
    @Injected var modelContext: ModelContext
    
    func save(_ site: Site) {
        let order = fetchDTO().count + 1
        let siteDTO = SiteDTO(siteName: site.siteName, siteURL: site.siteURL, order: order)
        
        modelContext.insert(siteDTO)
                
        do {
            try modelContext.save()
            print("💾 Site 저장완료 (id: \(site.id), title: \(site.siteName)")
        } catch {
            print("⚠️ Site 저장실패: \(error)")
        }
    }
    
    func fetch() -> [Site] {
        let siteDTOs: [SiteDTO] = fetchDTO()
        return siteDTOs.map{ $0.toEntity() }
    }
    
    func fetchDTO() -> [SiteDTO] {
        let descriptor = FetchDescriptor<SiteDTO>(sortBy: [SortDescriptor(\.updateDate, order: .reverse)])
        
        do {
            return try modelContext.fetch(descriptor)
        } catch {
            print("⚠️ SiteDTO 가져오기 실패: \(error)")
            return []
        }
    }
    
    func delete(siteId: String) {
        do {
            let fetchedSites = fetchDTO()
            if let siteToDelete = fetchedSites.first(where: { $0.id == siteId }) {
                modelContext.delete(siteToDelete)
                try modelContext.save()
                print("🗑️ Site 삭제완료 (id: \(siteToDelete.id), title: \(siteToDelete.siteName)")
            }
        } catch {
            print("⚠️ Site 삭제실패: \(error)")
        }
    }
}
