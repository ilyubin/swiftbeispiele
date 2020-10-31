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
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel[section].cells.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = viewModel[indexPath.section].cells[indexPath.row]
        switch model {
//        case .grid2(imageName: let imageName, text: let text):
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "grid2cell", for: indexPath) as! Grid2Cell
//            cell.imageView.image = UIImage(named: imageName)
//            cell.label.text = text
//            return cell
        case .carousel(items: let items):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselCell", for: indexPath) as! CarouselCell
            cell.configure(with: items)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            fatalError()
        }
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! HeaderReusableView
        header.label.text = viewModel[indexPath.section].header
        return header
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.count
    }
}

extension ViewController: UICollectionViewDelegate {

}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model = viewModel[indexPath.section].cells[indexPath.row]
        let l = collectionViewLayout as! UICollectionViewFlowLayout
        switch model {
//        case .grid2:
//            let w = (view.bounds.width - l.sectionInset.left - l.sectionInset.right - l.minimumInteritemSpacing) / 2
//            return CGSize(width: w, height: 60)
        case .carousel:
            let w = view.bounds.width - l.sectionInset.left - l.sectionInset.right
            return CGSize(width: w, height: 160)
        }
    }
}
