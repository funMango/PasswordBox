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
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(viewModel.site.sitename)
                    .fontWeight(.regular)
                
                Text(verbatim: "example@example.com")
                    .foregroundStyle(Color.gray)
                    .font(.caption)
            }
            
            Spacer()
        }
        .frame(height: 40)
    }
}

#Preview {
    SiteListCellView(
        viewModel: SiteListCellViewModel(
            site: Account(sitename: "Amazone")
        )
    )
}
