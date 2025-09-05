//
//  SiteSortBtnViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 9/4/25.
//

import Foundation
import Resolver
import Combine

class SiteSortBtnViewModel<T: SortOption>: ObservableObject, ControlMessageBindable {
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    var cancellables: Set<AnyCancellable> = []
    var type: T
    
    init(type: T) {
        self.type = type
    }
}
