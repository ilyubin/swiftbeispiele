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
    var alarms: [Alarm] { get set }
    func save()
}

class AlarmStore: AlarmStoreProtocol {
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
    
    func save() {
        print("saving alarms to file \(alarmStoreURL)")
        do {
            let data = try JSONEncoder().encode(alarms)
            try data.write(to: alarmStoreURL)
        } catch {
            print(error)
        }
    }
    
    init() {
        guard
            let data = try? Data(contentsOf: alarmStoreURL),
            let decodedAlarms = try? JSONDecoder().decode([Alarm].self, from: data) else {
            alarms = []
            return
        }
        alarms = decodedAlarms
    }
}
