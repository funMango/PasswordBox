//
//  ControlMessage.swift
//  PasswordBox
//
//  Created by 이민호 on 8/11/25.
//

import Foundation
import Combine

enum ControlMessage{
    case toggleIsShowingAccountAddSheet
    case setupSiteOrder(AccountOrder, AccountOrderBy)
    case activateSiteTextField
    case activateSocialTextField
    case updateSitename(String)    
    case syncIcloud
    case deleteSocialId
    
    /// searchBar
    case focusSearchBar
    case deFocusSearchBar
    case changeSearchType(SearchType)
    case selectAllInSearchBar
    
    /// Cloud
    case connectingCloud
    case cloudConnected
    case cloudConnectionFailed
    
    /// Sort
    case updateSortInfo
    
    /// Toolbar Title
    case toolbarTitleAppear
    case toolbarTitleDisappear
}

protocol ControlMessageBindable: AnyObject {
    var controlSubject: PassthroughSubject<ControlMessage, Never> { get }
    var cancellables: Set<AnyCancellable> { get set }
}

extension ControlMessageBindable {
    func bindControlMessage(action: @escaping (ControlMessage) -> Void) {
        controlSubject
            .sink(receiveValue: action)
            .store(in: &cancellables)
    }
}
