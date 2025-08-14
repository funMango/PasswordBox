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
            ForEach(sites, id: \.id) { site in
                SiteListCellView(
                    viewModel: SiteListCellViewModel(site: site)
                )
            }
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

struct SiteListCell: View {
    var body: some View {
        
    }
}

#Preview {
    SiteListView()
}
