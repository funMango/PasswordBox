//
//  SiteListCellView.swift
//  PasswordBox
//
//  Created by 이민호 on 8/11/25.
//

import SwiftUI

struct SiteListCellView: View {
    @StateObject var viewModel: SiteListCellViewModel
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "lock.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 38, height: 38)
                .foregroundStyle(.gray)
            
            VStack(alignment: .leading) {
                Text(viewModel.name)
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
    SiteListCellView(viewModel: SiteListCellViewModel(name: "Amazone"))
}
