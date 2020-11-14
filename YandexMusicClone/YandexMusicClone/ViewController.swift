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
                        CarouselItem(imageName: "l1", text: "Brassic TV-series", subText: "Updated today"),
                        CarouselItem(imageName: "l2", text: "THE ALBUM", subText: "Updated yesterday"),
                        CarouselItem(imageName: "l3", text: "Mood booster", subText: "Updated 12.11"),
                        CarouselItem(imageName: "l4", text: "That's The Spirit", subText: "Updated 12.11"),
                        CarouselItem(imageName: "l5", text: "Up&Up", subText: "Updated 11.11"),
                        CarouselItem(imageName: "l1", text: "The Saga of Wiz Khalifa (Deluxe)", subText: "Updated 11.11"),
                        CarouselItem(imageName: "l2", text: "Любимые треки", subText: "Updated 10.11"),
                    ]
                ),
            ]
        ),
        SectionViewModel(
            header: "Podcasts",
            cells: [
                .carousel(
                    items: [
                        CarouselItem(imageName: "l1", text: "Англиский по хитам с флоу и еще немного текста", subText: "9 episodes"),
                        CarouselItem(imageName: "l2", text: "THE ALBUM", subText: "4 episodes"),
                        CarouselItem(imageName: "l3", text: "Mood booster", subText: "100 episodes"),
                        CarouselItem(imageName: "l4", text: "That's The Spirit", subText: "9 episodes"),
                        CarouselItem(imageName: "l5", text: "Up&Up", subText: "13 episodes"),
                    ]
                ),
            ]
        ),
        SectionViewModel(
            header: "Mixes",
            cells: [
                .grid(
                    items: [
                        GridItem(imageName: "l1", text: "Popular", color: "9 episodes"),
                        GridItem(imageName: "l2", text: "New", color: "4 episodes"),
                        GridItem(imageName: "l3", text: "Timeless Hits", color: "100 episodes"),
                        GridItem(imageName: "l4", text: "That's The Spirit", color: "9 episodes"),
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
        case .grid(items: let items):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gridCell", for: indexPath) as! GridCell
            cell.configureGrid(with: items)
            return cell
        case .carousel(items: let items):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselCell", for: indexPath) as! CarouselCell
            cell.configureCarousel(with: items)
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
        case .grid:
            let w = (view.bounds.width - l.sectionInset.left - l.sectionInset.right - l.minimumInteritemSpacing) / 2
            return CGSize(width: w, height: 60)
        case .carousel:
            let w = view.bounds.width - l.sectionInset.left - l.sectionInset.right
            return CGSize(width: w, height: 240)
        }
    }
}
