//
//  AlarmDetailsViewController.swift
//  Alarms
//
//  Created by Lyubin Igor on 09.09.2020.
//

import UIKit

protocol AlarmDetailsViewControllerProtocol: AnyObject {
    func showAlarm(id: UUID)
}

class AlarmDetailsViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var notifySwitch: UISwitch!
    //DI
    var id: UUID!
    var alarmStore: AlarmStoreProtocol!
    var router: RouterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAlarm(id: id)
    }
    
    @IBAction func setNameTapped(_ sender: Any) {
        
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        alarmStore.deleteAlarm(with: id)
    }
    
    @IBAction func notifySwitchChanged(_ sender: UISwitch) {
        alarmStore.updateAlarm(with: id) {
            $0.shouldNotify = sender.isOn
        }
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        alarmStore.updateAlarm(with: id) {
            $0.alarmDate = sender.date
        }
    }
}

extension AlarmDetailsViewController: AlarmDetailsViewControllerProtocol {
    func showAlarm(id: UUID) {
        guard let alarm = alarmStore.alarms.first(where: {$0.id == id}) else {
            fatalError("Unknown alarm uuid")
        }
        self.id = id
        datePicker.date = alarm.alarmDate
        notifySwitch.isOn = alarm.shouldNotify
    }
}
