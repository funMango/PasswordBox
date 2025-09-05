//
//  SiteSortBtnViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 9/4/25.
//

import Foundation
import Resolver
import Combine

class SiteSortBtnViewModel: ObservableObject, ControlMessageBindable {
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    var cancellables: Set<AnyCancellable> = []

    
}
