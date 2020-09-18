//
//  AlarmStore.swift
//  Alarms
//
//  Created by Vladimir Inozemtsev on 29.08.2020.
//

import Foundation

extension Notification.Name {
    static let AlarmStoreDidUpdateData = Notification.Name(rawValue: "alarm.store.update.data")
}

protocol AlarmStoreProtocol: AnyObject {
    var alarms: [Alarm] { get }
    func createAlarm() -> UUID
    func updateAlarm(with: UUID, modification: (inout Alarm) -> Void)
    func deleteAlarm(with: UUID)
    func save()
}

class AlarmStore: AlarmStoreProtocol {
    
    private let notificationService: UserNotificationServiceProtocol
    
    private let alarmStoreURL: URL = {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent("alarms.data")
    }()
    
    var alarms: [Alarm] {
        didSet {
            let notification = Notification(name: .AlarmStoreDidUpdateData)
            NotificationCenter.default.post(notification)
        }
    }
    
    init(notificationService: UserNotificationServiceProtocol) {
        self.notificationService = notificationService

        guard
            let data = try? Data(contentsOf: alarmStoreURL),
            let decodedAlarms = try? JSONDecoder().decode([Alarm].self, from: data) else {
            alarms = []
            return
        }
        alarms = decodedAlarms
    }
    
    func createAlarm() -> UUID {
        let alarm = Alarm()
        alarms.append(alarm)
        notificationService.scheduleNotification(from: alarm)
        save()
        return alarm.id
    }
    
    func updateAlarm(with id: UUID, modification: (inout Alarm) -> Void) {
        guard let index = alarms.firstIndex(where: { $0.id == id }) else {
            fatalError("no alarm with index \(id)")
        }
        modification(&alarms[index])
        save()
        let alarm = alarms[index]
        if !alarm.shouldNotify {
            notificationService.removeNotification(with: alarm.id)
            return
        }
        notificationService.scheduleNotification(from: alarm)
    }
    
    func deleteAlarm(with id: UUID) {
        alarms.removeAll(where: { $0.id == id })
        notificationService.removeNotification(with: id)
        save()
    }
    
    func save() {
        print("saving alarms to file \(alarmStoreURL)")
        do {
            let data = try JSONEncoder().encode(alarms)
            try data.write(to: alarmStoreURL)
        } catch {
            print(error)
        }
    }
}
