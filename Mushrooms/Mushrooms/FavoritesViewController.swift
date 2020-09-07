//
//  FavoritesViewController.swift
//  Mushrooms
//
//  Created by Lyubin Igor on 30.07.2020.
//  Copyright © 2020 AP Organization. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
   
    @IBAction func act(_ sender: AnyObject?) {
        guard let mushroomSelector = tabBarController?.viewControllers?.first as? MushroomSelector else {
            return
        }
        mushroomSelector.setPage(index: 0)
        tabBarController?.selectedIndex = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
