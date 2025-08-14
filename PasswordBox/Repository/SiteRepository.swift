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
    func delete(_ site: Site)
}

class DefaultSiteRepository: SiteRepository {
    @Injected var modelContext: ModelContext
    
    func save(_ site: Site) {
        modelContext.insert(site)
                
        do {
            try modelContext.save()
            print("💾 Site 저장완료 (id: \(site.id), title: \(site.siteName)")
        } catch {
            print("⚠️ Site 저장실패: \(error)")
        }
    }
    
    func fetch() -> [Site] {
        let descriptor = FetchDescriptor<Site>(sortBy: [SortDescriptor(\.updateDate, order: .reverse)])
        
        do {
            return try modelContext.fetch(descriptor)
        } catch {
            print("⚠️ Site 가져오기 실패: \(error)")
            return []
        }
    }
    
    func delete(_ site: Site) {
        modelContext.delete(site)
        
        do {
            try modelContext.save()
            print("🗑️ Site 삭제완료 (id: \(site.id), title: \(site.siteName)")
        } catch {
            print("⚠️ Site 삭제실패: \(error)")
        }
    }
}
