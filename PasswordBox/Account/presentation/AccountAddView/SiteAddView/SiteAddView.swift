//
//  SiteAddView.swift
//  PasswordBox
//
//  Created by 이민호 on 9/8/25.
//

import SwiftUI

struct SiteAddView: View {
    @StateObject var viewModel = SiteAddViewModel(filter: DefalutAccountInfoFilter())    
    
    var body: some View {
        List {
            SearchSectionView(
                placeholder: "searchOrCreateSite",
                textBinding: $viewModel.text,
                onSubmit: {
                    viewModel.updateSite()
                }
            )
            
            AccountFilteredSectionView(
                filteredAccounts: $viewModel.filteredAccounts,
                text: viewModel.text,
                updateItem: viewModel.updateSite,
                setItem: { account in
                    viewModel.setSite(from: account.sitename)
                },
                cellView: { account in
                    Text(account.sitename)
                }
            )
        }
        .scrollDismissesKeyboard(.immediately)        
    }
}

#Preview {
    SiteAddView()
}
