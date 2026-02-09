//
//  AccountWrapperExtension.swift
//  PasswordBox
//
//  Created by 이민호 on 1/17/26.
//

import Foundation
import Combine

protocol AccountWrapperBindable: AnyObject {
    var accountWrapperSubject: CurrentValueSubject<[Account], Never> { get }
    var cancellables: Set<AnyCancellable> { get set }
}

extension AccountWrapperBindable {
    func bindAccountWrappers(action: @escaping ([Account]) -> Void) {
        accountWrapperSubject
            .receive(on: DispatchQueue.main) // @MainActor지만 명시하면 안전
            .sink { wrappers in
                action(wrappers)
            }
            .store(in: &cancellables)
    }
}
