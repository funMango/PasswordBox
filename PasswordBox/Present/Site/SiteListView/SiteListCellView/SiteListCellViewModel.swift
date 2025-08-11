//
//  SiteListCellViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 8/11/25.
//

import Foundation

class SiteListCellViewModel: ObservableObject {
    @Published var name: String
    
    init(name: String){
        self.name = name
    }        
}
