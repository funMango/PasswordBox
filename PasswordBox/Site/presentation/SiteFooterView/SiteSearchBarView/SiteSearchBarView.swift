//
//  SiteSearchBarView.swift
//  PasswordBox
//
//  Created by 이민호 on 9/2/25.
//

import SwiftUI

struct SiteSearchBarView: View {
    @StateObject var viewModel = SiteSearchBarViewModel()
    
    var body: some View {
        TextField(String(localized: "search"), text: $viewModel.text)
            .searchBarStyle()
            
    }
}

#Preview {
    SiteSearchBarView()
}
