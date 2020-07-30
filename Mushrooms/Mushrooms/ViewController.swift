//
//  ViewController.swift
//  Mushrooms
//
//  Created by Lyubin Igor on 29.07.2020.
//  Copyright © 2020 AP Organization. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mushroomTitle: UILabel!
    @IBOutlet weak var mushroomDescription: UITextView!
    @IBOutlet weak var mushroomPicture: UIImageView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    var mushrooms: [Mushroom] = []
    var index: Int = 0

    fileprivate func setupDescriptionTextContainer() {
        mushroomDescription.textContainer.lineFragmentPadding = 0
        mushroomDescription.textContainerInset = .zero
    }
    
    fileprivate func plusIndex() {
        index = (index + 1) % mushrooms.count
    }

    fileprivate func minusIndex() {
        if (index - 1 < 0) {
            index = mushrooms.count - 1
            return
        }
        index -= 1
    }

    fileprivate func showMushroomByIndex(index: Int) {
        let m = mushrooms[index]
        mushroomTitle.text = m.title
        mushroomDescription.text = m.description
        mushroomPicture.image = UIImage(named: (m.picture))
        showFavButton(isFavorite: m.isFavorite)
    }
    
    fileprivate func showPrevButton() {
        prevButton.setTitle("prev", for: .normal)
    }
    
    fileprivate func showNextButton() {
        nextButton.setTitle("next", for: .normal)
    }
    
    fileprivate func showFavButton(isFavorite: Bool) {
        let title = isFavorite ? "remove from favorite" : "to favorite"
        favButton.setTitle(title, for: .normal)
    }
    
    @IBAction func goPrev(_ sender: AnyObject?) {
        minusIndex()
        showMushroomByIndex(index: index)
    }

    @IBAction func goNext(_ sender: AnyObject?) {
        plusIndex()
        showMushroomByIndex(index: index)
    }
    
    @IBAction func addToFavorite(_ sender: AnyObject?) {
        mushrooms[index].isFavorite = !mushrooms[index].isFavorite
        showFavButton(isFavorite: mushrooms[index].isFavorite)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupDescriptionTextContainer()
        
        mushrooms = getMushrooms()
        
        showMushroomByIndex(index: 0)
        showPrevButton()
        showNextButton()
    }
}

