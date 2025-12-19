//
//  IcloudStateView.swift
//  PasswordBox
//
//  Created by 이민호 on 12/10/25.
//

import SwiftUI

struct IcloudStateView: View {
    @StateObject var viewModel = IcloudStateViewModel()
    
    var body: some View {
        HStack {
            Image(systemName: viewModel.state.rawValue)
                .foregroundStyle(.gray)
            
            if viewModel.state == .syncing {
                ProgressView()
            }
        }
    }
}

#Preview {
    IcloudStateView()
}
