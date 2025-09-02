//
//  SiteMessage.swift
//  PasswordBox
//
//  Created by 이민호 on 9/2/25.
//

import Foundation
import Combine

enum SiteMessage {
    case changeSearchText(String)
}

protocol SiteMessageBindable: AnyObject {
    var siteSubject: PassthroughSubject<SiteMessage, Never> { get }
    var cancellables: Set<AnyCancellable> { get set }
}

extension SiteMessageBindable {
    func bindSiteMessage(action: @escaping (SiteMessage) -> Void) {
        siteSubject
            .sink(receiveValue: action)
            .store(in: &cancellables)
    }
}
