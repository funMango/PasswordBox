//
//  SiteListView.swift
//  PasswordBox
//
//  Created by 이민호 on 8/11/25.
//

import SwiftUI

struct SiteListView: View {
    @State var samples: [String] = [
        "Goggle", "Naver", "Amazone","Goggle", "Naver", "Amazone","Goggle", "Naver", "Amazone","Goggle", "Naver", "Amazone","Goggle", "Naver", "Amazone","Goggle", "Naver", "Amazone"
    ]
    
    var body: some View {
        List {
            ForEach(samples, id: \.self) { site in
                SiteListCellView(
                    viewModel: SiteListCellViewModel(name: site)
                )
            }
        }
        .listStyle(.plain)
        .navigationTitle("Site")
    }
}

struct SiteListCell: View {
    var body: some View {
        
    }
}

#Preview {
    SiteListView()
}
