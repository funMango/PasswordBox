//
//  ContentView.swift
//  PasswordBox
//
//  Created by 이민호 on 8/10/25.
//

import SwiftUI

struct SiteView: View {
    @StateObject var viewModel = SiteViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                SiteListView()
                
                SiteFooterView()
            }
            .sheet(isPresented: $viewModel.isShowingSiteAddSheet) {
                SiteAddView()
            }
        }
    }
}

#Preview {
    SiteView()
}
