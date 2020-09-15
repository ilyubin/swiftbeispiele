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
    func openAlarmDetails(withID: UUID, style: PresentationStyle)
    func pop()
    func openAlarmEditDialog(completion: @escaping (String?) -> Void)
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
    
    func openAlarmDetails(withID id: UUID, style: PresentationStyle) {
        let detailsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "AlarmDetail") as! AlarmDetailsViewController
        detailsController.alarmStore = alarmStore
        detailsController.router = self
        detailsController.id = id
        switch style {
        case .push:
            topNavigationController.pushViewController(detailsController, animated: true)
        case .present:
            break
        }
    }
    
    func pop() {
        topNavigationController.popViewController(animated: true)
    }
    
    func openAlarmEditDialog(completion: @escaping (String?) -> Void) {
        let alertController = UIAlertController(
            title: "Name",
            message: "Enter alarm name",
            preferredStyle: .alert
        )
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            //getting the input values from user
            let name = alertController.textFields?[0].text
            completion(name)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        topNavigationController.present(alertController, animated: true, completion: nil)
    }
}
