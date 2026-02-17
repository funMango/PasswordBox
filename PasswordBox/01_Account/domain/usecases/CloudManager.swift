//
//  CloudManager.swift
//  PasswordBox
//
//  Created by 이민호 on 12/4/25.
//

import SwiftUI
import CoreData

enum CloudSyncEvents {
    case started
    case finished
    case imported
    case failed(Error)
}

enum CycleError: Error {
    case timedOut
}

protocol CloudManager {
    func awaitSyncCycle(maxWait seconds: TimeInterval) async -> Result<Void, Error>
}

final class DefaultCloudManager: CloudManager {
    private var observer: NSObjectProtocol?
    
    func awaitSyncCycle(maxWait seconds: TimeInterval = 10) async -> Result<Void, Error> {
        await withTaskGroup(of: Result<Void, Error>.self) { group in
            /// 1) 이벤트 소비 태스크
            group.addTask { [weak self] in
                guard let self else { return .failure(CycleError.timedOut) }
                for await state in self.events() {
                    switch state {
                    case .started:
                        continue
                    case .finished:
                        return .success(())
                    case .imported:
                        continue
                    case .failed(let error):
                        return .failure(error)
                    }
                }
                return .failure(CycleError.timedOut)
            }

            /// 2) 타임아웃 태스크
            group.addTask {
                try? await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
                return .failure(CycleError.timedOut)
            }

            /// 먼저 완료되는 결과를 채택
            let first = await group.next() ?? .failure(CycleError.timedOut)
            group.cancelAll()
            return first
        }
    }
    
    private func events() -> AsyncStream<CloudSyncEvents> {
        AsyncStream { continuation in
            observer = NotificationCenter.default.addObserver(
                forName: NSPersistentCloudKitContainer.eventChangedNotification,
                object: nil,
                queue: .main
            ) { note in
                guard let event = note.userInfo?[NSPersistentCloudKitContainer.eventNotificationUserInfoKey] as? NSPersistentCloudKitContainer.Event else { return }

                if event.endDate == nil {
                    continuation.yield(.started)
                    return
                }

                /// 종료됨
                if event.type == .import {
                    continuation.yield(.imported)
                }
                continuation.yield(.finished)
            }

            continuation.onTermination = { [weak self] _ in
                if let observer = self?.observer {
                    NotificationCenter.default.removeObserver(observer)
                    self?.observer = nil
                }
            }
        }
    }
}

