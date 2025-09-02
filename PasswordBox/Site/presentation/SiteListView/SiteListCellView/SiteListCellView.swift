//
//  SiteListCellView.swift
//  PasswordBox
//
//  Created by 이민호 on 8/11/25.
//

import SwiftUI

struct SiteListCellView: View {
    @StateObject var viewModel: SiteListCellViewModel
    
    init(viewModel: SiteListCellViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        HStack(spacing: 12) {
            Icon(
                name: "lock.circle.fill",
                color: .gray
            )
            
            VStack(alignment: .leading) {
                Text(viewModel.site.siteName)
                    .fontWeight(.regular)
                
                Text("1개의 계정")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
                                    
            Spacer()
        }
        .frame(height: 40)
    }
}

#Preview {
    SiteListCellView(
        viewModel: SiteListCellViewModel(
            site: Site(siteName: "Amazone", order: 0)
        )
    )
}
