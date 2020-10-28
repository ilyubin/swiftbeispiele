//
//  ViewController.swift
//  YandexMusicClone
//
//  Created by Lyubin Igor on 19.10.2020.
//  Copyright © 2020 AP Organization. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet
    weak var collectionView: UICollectionView!
    
    let viewModel: [SectionViewModel] = [
        SectionViewModel(
            header: "Based on your preferences",
            cells: [
                .carousel(
                    items: [
                        CarouselItem(imageName: "l1", text: "Brassic TV-series", subText: "1"),
                        CarouselItem(imageName: "l2", text: "THE ALBUM", subText: "2"),
                        CarouselItem(imageName: "l3", text: "Mood booster", subText: "3"),
                        CarouselItem(imageName: "l4", text: "That's The Spirit", subText: "4"),
                        CarouselItem(imageName: "l5", text: "Up&Up", subText: "5"),
                        CarouselItem(imageName: "l1", text: "The Saga of Wiz Khalifa (Deluxe)", subText: "6"),
                        CarouselItem(imageName: "l2", text: "Любимые треки", subText: "7"),
                    ]
                ),
            ]
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        collectionView.dataSource = self
//        collectionView.delegate = self
        collectionView.reloadData()
    }


}

