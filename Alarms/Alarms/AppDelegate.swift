//
//  AppDelegate.swift
//  Alarms
//
//  Created by Vladimir Inozemtsev on 29.08.2020.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // Хранилище будильников
    private let alarmStore = AlarmStore()
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //alarmStore.alarms.append(Alarm(name: "A1", alarmDate: Date().addingTimeInterval(200), shouldNotify: true))
        //alarmStore.alarms.append(Alarm(name: "A2", alarmDate: Date().addingTimeInterval(10000), shouldNotify: true))
        
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "MainViewController") as! ViewController
        let rootViewController = UINavigationController(rootViewController: mainViewController)
        
        let router = Router(alarmStore: alarmStore, topNavigationController: rootViewController)
        
        //DI
        mainViewController.alarmStore = alarmStore
        mainViewController.router = router
        
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        alarmStore.save()
    }
}
