//
//  ViewController.swift
//  Mushrooms
//
//  Created by Lyubin Igor on 29.07.2020.
//  Copyright © 2020 AP Organization. All rights reserved.
//

import UIKit

protocol MushroomSelector {
    func setPage(index: Int)
}

class ViewController: UIViewController {
    
    @IBOutlet weak var mushroomTitle: UILabel!
    @IBOutlet weak var mushroomDescription: UITextView!
    @IBOutlet weak var mushroomPicture: UIImageView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var favIcon: UIImageView!
    
    var mushrooms: [Mushroom] = []
    var index: Int = 0

    fileprivate func setupDescriptionTextContainer() {
        mushroomDescription.textContainer.lineFragmentPadding = 0
        mushroomDescription.textContainerInset = .zero
        mushroomDescription.isEditable = false
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
        mushroomDescription.contentOffset = .zero
        let m = mushrooms[index]
        mushroomTitle.text = m.title
        mushroomDescription.text = m.description
        mushroomPicture.image = UIImage(named: (m.picture))
        showFavIcon(isFavorite: m.isFavorite)
    }
    
    fileprivate func showPrevButton() {
        prevButton.setTitle("prev", for: .normal)
    }
    
    fileprivate func showNextButton() {
        nextButton.setTitle("next", for: .normal)
    }
    
    fileprivate func showFavIcon(isFavorite: Bool) {
        let iconName = isFavorite ? "star.fill" : "star"
        favIcon.image = UIImage(systemName: iconName)
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
        showFavIcon(isFavorite: mushrooms[index].isFavorite)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
       if gesture.direction == .right {
            goPrev(nil)
            return
       }
       if gesture.direction == .left {
            goNext(nil)
       }
    }
    
    fileprivate func addGesture(_ direction: UISwipeGestureRecognizer.Direction) {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = direction
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupDescriptionTextContainer()
        favIcon.isUserInteractionEnabled = true
        
        mushrooms = getMushrooms()
        
        showMushroomByIndex(index: 0)
        showPrevButton()
        showNextButton()
        
        addGesture(.left)
        addGesture(.right)
    }
}

extension ViewController : MushroomSelector {
    func setPage(index: Int) {
        guard index >= 0, index < mushrooms.count else {
            return
        }
        showMushroomByIndex(index: index)
    }
}
