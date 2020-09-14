//
//  Router.swift
//  Alarms
//
//  Created by Vladimir Inozemtsev on 29.08.2020.
//

import Foundation
import UIKit

enum PresentationStyle {
    case push, present
}

protocol RouterProtocol: AnyObject {
    func pop()
}

class Router: RouterProtocol {
    private let alarmStore: AlarmStoreProtocol
    private let topNavigationController: UINavigationController
    
    init(
        alarmStore: AlarmStoreProtocol,
        topNavigationController: UINavigationController
    ) {
        self.alarmStore = alarmStore
        self.topNavigationController = topNavigationController
    }
    
    func pop() {
        topNavigationController.popViewController(animated: true)
    }
}
