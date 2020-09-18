//
//  UserNotificationService.swift
//  Alarms
//
//  Created by Vladimir Inozemtsev on 09.09.2020.
//

import Foundation
import UserNotifications

protocol UserNotificationServiceProtocol: AnyObject {
    func requestAuthorization()
    func scheduleNotification(from alarm: Alarm)
    func removeNotification(with id: UUID)
}

class UserNotificationService: NSObject, UserNotificationServiceProtocol {
    
    private let notificationCenter = UNUserNotificationCenter.current()
    
    var router: RouterProtocol?
    var alarmStore: AlarmStoreProtocol?
    
    func requestAuthorization() {
        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
    }
    
    func scheduleNotification(from alarm: Alarm) {
        
        let content = UNMutableNotificationContent() // Содержимое уведомления
        let userActions = "User Actions"
        
        content.title = "Alarm trigger"
        content.body = "Alarm \(alarm.name ?? "with no name") triggered"
        content.sound = UNNotificationSound.default
        content.badge = 1
        content.categoryIdentifier = userActions
        
        let dateComponents = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: alarm.alarmDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let identifier = alarm.id.uuidString
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        
        let snoozeAction = UNNotificationAction(identifier: .snoozeActionIdentifier, title: "Snooze", options: [])
        let deleteAction = UNNotificationAction(identifier: .deleteActionIdentifier, title: "Delete", options: [.destructive])
        let category = UNNotificationCategory(
            identifier: userActions,
            actions: [snoozeAction, deleteAction],
            intentIdentifiers: [],
            options: []
        )
        
        notificationCenter.setNotificationCategories([category])
    }
    
    func removeNotification(with id: UUID) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [id.uuidString])
    }
}

extension UserNotificationService: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        defer {
            completionHandler()
        }
        
        guard let uuid = UUID(uuidString: response.notification.request.identifier) else { return }
        
        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            
            router?.openAlarmDetails(withID: uuid, style: .push)
            
        case .snoozeActionIdentifier:
            
            alarmStore?.updateAlarm(with: uuid) {
                $0.alarmDate = $0.alarmDate.addingTimeInterval(60)
            }
            
        case .deleteActionIdentifier:
            
            alarmStore?.deleteAlarm(with: uuid)
            
        default:
            break
        }
    
    }
}

private extension String {
    static let snoozeActionIdentifier = "Snooze"
    static let deleteActionIdentifier = "Delete"
}
