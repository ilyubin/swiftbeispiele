//
//  FavoritesViewController.swift
//  Mushrooms
//
//  Created by Lyubin Igor on 30.07.2020.
//  Copyright © 2020 AP Organization. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func act(_ sender: AnyObject?) {
        guard let mushroomSelector = tabBarController?.viewControllers?.first as? MushroomSelector else {
            return
        }
        mushroomSelector.setPage(index: 0)
        tabBarController?.selectedIndex = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .cellReuseIdentifier, for: indexPath)
        cell.textLabel?.text = "Бип"
        cell.detailTextLabel?.text = "Белый"
        return cell
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Обрабатываем выбор ячейки
    }
}

private extension String {
    static let cellReuseIdentifier = "Cell"
}
