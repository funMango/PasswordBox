//
//  SiteListView.swift
//  PasswordBox
//
//  Created by 이민호 on 8/11/25.
//

import SwiftUI
import SwiftData

struct SiteListView: View {
    @StateObject var viewModel = SiteListViewModel()
    @Query var sites: [Site]
    
    var body: some View {
        List {
            ForEach(viewModel.sites, id: \.id) { site in
                NavigationLink {
                    SiteDetailView(
                        viewModel: SiteDetailViewModel(site: site)
                    )
                } label: {
                    SiteListCellView(
                        viewModel: SiteListCellViewModel(site: site)
                    )
                }                
            }
            .onDelete(perform: viewModel.deleteSite)
        }
        .listStyle(.plain)
        .navigationTitle("Site")
        .onAppear() {
            viewModel.setSites(sites)
        }
        .onChange(of: sites) { _, newValue in
            viewModel.setSites(newValue)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Site.self, configurations: config)
        
    let site1 = Site(siteName: "Google")
    let site2 = Site(siteName: "Apple")
    container.mainContext.insert(site1)
    container.mainContext.insert(site2)
    
    return SiteListView()
        .modelContainer(container)
}
