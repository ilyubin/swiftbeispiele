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
            detailsController.canBeDeleted = true
            topNavigationController.pushViewController(detailsController, animated: true)
        case .present:
            detailsController.modalPresentationStyle = .automatic
            detailsController.canBeDeleted = false
            let navigationController = UINavigationController(rootViewController: detailsController)
            let saveButton: UIBarButtonItem = UIBarButtonItem(
                title: "Save",
                style: .plain,
                target: detailsController,
                action: #selector(AlarmDetailsViewController.saveAlarm)
            )
            detailsController.navigationItem.rightBarButtonItem = saveButton
            let cancelButton: UIBarButtonItem = UIBarButtonItem(
                title: "Cancel",
                style: .plain, target:
            detailsController,
                action: #selector(AlarmDetailsViewController.cancelAlarm)
            )
            detailsController.navigationItem.leftBarButtonItem = cancelButton
            topNavigationController.present(navigationController, animated: true, completion: nil)
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
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
        }

        alertController.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        topNavigationController.present(alertController, animated: true, completion: nil)
    }
}
