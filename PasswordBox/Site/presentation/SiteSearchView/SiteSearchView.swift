//
//  SiteSearchView.swift
//  PasswordBox
//
//  Created by 이민호 on 8/31/25.
//

import SwiftUI
import SwiftData

enum SearchTextFields: Hashable {
    case search
}

struct SiteSearchView: View {
    @StateObject var viewModel = SiteSearchViewModel()
    @Environment(\.dismiss) var dismiss
    @Query var sites: [SiteDTO]
    @State private var searchIsActive = true
    
    
    var body: some View {
        
        List {
            ForEach(viewModel.filterdSites, id: \.self) { site in
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
        }
        .listStyle(.plain)
        
//        .onTapGesture {
//            searchIsActive = false
//        }                                                    
        .onAppear() {
            viewModel.fetchSites()
        }
        .navigationBarBackButtonHidden()
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Icon(
                        name: "chevron.left",
                        size: .small,
                        color: .blackWhite
                    )
                }
            }
        }
        .searchable(
            text: $viewModel.searchText,
            isPresented: $searchIsActive,
            placement: .navigationBarDrawer(displayMode: .always)
        )
    }
}

#Preview {
    SiteSearchView()
}
