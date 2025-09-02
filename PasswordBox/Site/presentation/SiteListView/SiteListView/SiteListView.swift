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
    @Query var sites: [SiteDTO]
    
    var body: some View {
        List {
            ForEach(viewModel.filteredSites, id: \.self) { site in
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
        .safeAreaInset(edge: .bottom) {
            SiteFooterView()
        }
        .listStyle(.plain)
        .navigationTitle("Site")
        .onAppear() {
            viewModel.fetchSites()
        }
        .onChange(of: sites) { _, _ in
            viewModel.fetchSites()
        }
    }
}

#Preview {
    SiteListView()
}
