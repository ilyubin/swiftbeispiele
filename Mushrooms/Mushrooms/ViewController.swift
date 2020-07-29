//
//  ViewController.swift
//  Mushrooms
//
//  Created by Lyubin Igor on 29.07.2020.
//  Copyright © 2020 AP Organization. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var t: UILabel!
    @IBOutlet weak var d: UITextView!
    @IBOutlet weak var p: UIImageView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    var mushrooms: [Mushroom] = []
    var index: Int = 0

    fileprivate func getValidArrayIndex(i: Int, arraySize: Int) -> Int {
        if (i < 0) {
            return (i + 100 * arraySize) % arraySize
        }
        return index % arraySize
    }

    fileprivate func showMushroomByIndex(index: Int) {
        let i = getValidArrayIndex(i: index, arraySize: mushrooms.count)
        let m = mushrooms[i]
        t.text = m.title
        d.text = m.description
        
        p.image = UIImage(named: (m.picture))
    }
    
    fileprivate func showPrevButton() {
        prevButton.setTitle("prev", for: .normal)
    }
    
    fileprivate func showNextButton() {
        nextButton.setTitle("next", for: .normal)
    }
    
    fileprivate func showFavButton() {
        favButton.setTitle("to favorite", for: .normal)
    }
    
    @IBAction func goPrev(_ sender: AnyObject?) {
        index -= 1
        showMushroomByIndex(index: index)
    }

    @IBAction func goNext(_ sender: AnyObject?) {
        index += 1
        showMushroomByIndex(index: index)
    }
    
    func addToFavorite(_ sender: AnyObject?) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mushrooms = getMushrooms()
        showMushroomByIndex(index: 0)
        showPrevButton()
        showNextButton()
        showFavButton()
    }
}

