//
//  SitenameMessage.swift
//  PasswordBox
//
//  Created by 이민호 on 9/29/25.
//

import Foundation
import Combine

protocol SitenameMessageBindable: AnyObject {
    var sitenameSubject: CurrentValueSubject<String?, Never> { get }
    var cancellables: Set<AnyCancellable> { get set }
}

extension SitenameMessageBindable {
    func bindSitenameMessage(action: @escaping (String?) -> Void) {
        sitenameSubject
            .compactMap{ $0 }
            .filter { !$0.isEmpty }
            .removeDuplicates()
            .sink(receiveValue: action)
            .store(in: &cancellables)
    }
}
