//
//  SiteFooterVIew2.swift
//  PasswordBox
//
//  Created by 이민호 on 9/1/25.
//

import SwiftUI

struct SiteFooterView: View {
    @StateObject var viewModel = SiteFooterViewModel()
    
    var body: some View {
        HStack(spacing: 10) {
            if !viewModel.isSearchBarActive {
                SiteSortBtnView()
            }
                        
            SiteSearchBarView()
            
            SiteAddBtnView()
        }
        .padding()
    }
}

#Preview {
    SiteFooterView()
}
