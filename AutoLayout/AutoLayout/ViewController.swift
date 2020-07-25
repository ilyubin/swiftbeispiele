//
//  ViewController.swift
//  AutoLayout
//
//  Created by Lyubin Igor on 24.07.2020.
//  Copyright © 2020 AP Organization. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var topLeftView: UIView!
    @IBOutlet weak var topRightView: UIView!
    @IBOutlet weak var bottomLeftView: UIView!
    @IBOutlet weak var bottomRightView: UIView!

    fileprivate func stylizeView(_ v: UIView) {
        v.backgroundColor = .white
        v.layer.cornerRadius = 8
        v.layer.shadowOpacity = 0.3
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowRadius = 8
        v.layer.shadowOffset = CGSize(width: 4, height: 4)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        stylizeView(topLeftView)
        stylizeView(topRightView)
        stylizeView(bottomLeftView)
        stylizeView(bottomRightView)
    }
}
