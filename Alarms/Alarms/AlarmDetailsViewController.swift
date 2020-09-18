//
//  AlarmDetailsViewController.swift
//  Alarms
//
//  Created by Lyubin Igor on 09.09.2020.
//

import UIKit

protocol AlarmDetailsViewControllerProtocol: AnyObject {
    func showAlarm(id: UUID, canBeDeleted: Bool)
}

class AlarmDetailsViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var notifySwitch: UISwitch!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var setNameButton: UIButton!
    @IBOutlet weak var setNameTextField: UITextField!

    //DI
    var id: UUID!
    var alarmStore: AlarmStoreProtocol!
    var router: RouterProtocol!

    var canBeDeleted: Bool!
    var tempAlarmName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        showAlarm(id: id, canBeDeleted: canBeDeleted)
        setNameTextField.delegate = self
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleTextChange),
            name: UITextField.textDidChangeNotification,
            object: setNameTextField
        )
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard alarmStore.alarms.first(where: { $0.id == id }) != nil else {
            return
        }
        alarmStore.updateAlarm(with: id) { alarm in
            if alarm.name == tempAlarmName {
                return
            }
            alarm.name = tempAlarmName
        }
    }

    @IBAction func setNameTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.setNameTextField.isHidden = false
            self.setNameButton.isHidden = true
        }
    }

    @IBAction func deleteTapped(_ sender: Any) {
        alarmStore.deleteAlarm(with: id)
        // go to back
        router.pop()
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

    @objc func cancelAlarm() {
        alarmStore.deleteAlarm(with: id)
        dismiss(animated: true)
    }

    @objc func saveAlarm() {
        dismiss(animated: true)
    }

    @objc func handleTextChange(_ sender: Notification) {
        let s = setNameTextField.text
        tempAlarmName = s
        navigationItem.title = s
    }
}

extension AlarmDetailsViewController: AlarmDetailsViewControllerProtocol {
    func showAlarm(id: UUID, canBeDeleted: Bool) {
        guard let alarm = alarmStore.alarms.first(where: { $0.id == id }) else {
            fatalError("Unknown alarm uuid")
        }
        self.id = id
        datePicker.date = alarm.alarmDate
        notifySwitch.isOn = alarm.shouldNotify
        navigationItem.title = alarm.name ?? "Alarm"
        deleteButton.isHidden = !canBeDeleted
        setNameTextField.text = alarm.name ?? "Alarm"
    }
}

extension AlarmDetailsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // скрыть клавиатуры
        // firstResponsed = то текстовое поле куда кливатура шлет символы
        textField.resignFirstResponder()
        // скрываем текстовое поле, показываем кнопку
        UIView.animate(withDuration: 0.5) {
            self.setNameTextField.isHidden = true
            self.setNameButton.isHidden = false
        }
        return true
    }
}
