//
//  ViewController.swift
//  Alarms
//
//  Created by Vladimir Inozemtsev on 29.08.2020.
//

import UIKit

class ViewController: UIViewController {
    
    //DI
    var alarmStore: AlarmStoreProtocol!
    var router: RouterProtocol!
    
    @IBOutlet weak var tableView: UITableView!
    
    private let dateIntervalFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.second, .minute, .hour]
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Настраиваем tableView
        tableView.dataSource = self
        tableView.delegate = self
        
        //Перезагружаем список ячеек при изменениях в хранилище
        NotificationCenter.default.addObserver(self, selector: #selector(handleAlarmStoreUpdate), name: .AlarmStoreDidUpdateData, object: nil)
        
        let timer = Timer(timeInterval: 1, target: self, selector: #selector(handleTimer(_:)), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .common)
    }
    
    @objc private func handleAlarmStoreUpdate() {
        // Перезагружаем ячейки в table view
    }
    
    @objc private func handleTimer(_ sender: Any) {
        // Обработка таймера - обновляем оставшееся время в ячейках
        guard let indexPath = tableView.indexPathsForVisibleRows else { return }
        indexPath.forEach{
            guard let cell = tableView.cellForRow(at: $0) else { return }
            let alarm = alarmStore.alarms[$0.item]
            cell.detailTextLabel?.text = formatCellLeftTime(alarm: alarm)
        }
    }
    
    private func formatCellLeftTime(alarm : Alarm) -> String? {
        let currentDate = Date()
        // Обновляем время в ячейке
        if currentDate > alarm.alarmDate {
            return "Expired"
        }
        return dateIntervalFormatter.string(from: currentDate, to: alarm.alarmDate)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmStore.alarms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .cellReuseIdentifier, for: indexPath)
        let alarm = alarmStore.alarms[indexPath.item]
        cell.textLabel?.text = alarm.name ?? .defaultAlarmName
        cell.detailTextLabel?.text = formatCellLeftTime(alarm: alarm)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Обрабатываем выбор ячейки
    }
}

private extension String {
    static let cellReuseIdentifier = "Cell"
    static let defaultAlarmName = "Alarm"
}