//
//  AppDelegate.swift
//  Alarms
//
//  Created by Vladimir Inozemtsev on 29.08.2020.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // Хранилище будильников
    private var alarmStore: AlarmStore!
    private var notificationService: UserNotificationService!
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        //alarmStore.createAlarm()
        //alarmStore.createAlarm()

        notificationService = UserNotificationService()
        alarmStore = AlarmStore(notificationService: notificationService)

        window = UIWindow(frame: UIScreen.main.bounds)
        let mainViewController = UIStoryboard(
            name: "Main",
            bundle: .main
        ).instantiateViewController(identifier: "MainViewController") as! AlarmListViewController
        let rootViewController = UINavigationController(rootViewController: mainViewController)

        let router = Router(
            alarmStore: alarmStore,
            topNavigationController: rootViewController
        )

        //DI
        mainViewController.alarmStore = alarmStore
        mainViewController.router = router

        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()

        UNUserNotificationCenter.current().delegate = notificationService
        notificationService.requestAuthorization()
        notificationService.router = router
        notificationService.alarmStore = alarmStore

        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        alarmStore.save()
    }
}
