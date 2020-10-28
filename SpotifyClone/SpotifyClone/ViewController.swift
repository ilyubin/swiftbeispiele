//
//  ViewController.swift
//  SpotifyClone
//
//  Created by Lyubin Igor on 02.10.2020.
//  Copyright © 2020 AP Organization. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel: [SectionViewModel] = [
        SectionViewModel(
            header: "David Garrett",
            cells: [
                .grid2(imageName: "dg", text: "What A Wonderful World"),
                .grid2(imageName: "dgu", text: "Smooth Criminal"),
                .grid2(imageName: "dge", text: "Dangerous"),
                .grid2(imageName: "dgr", text: "Smell Like Teen Spirit"),
                .grid2(imageName: "dgrr", text: "Bitter Sweet Symphony"),
                .grid2(imageName: "dgt", text: "Allegro non troppo"),
            ]
        ),
        SectionViewModel(
            header: "Armin van Buuren",
            cells: [
                .grid2(imageName: "avb", text: "Que Passa"),
                .grid2(imageName: "avb1", text: "Black Lion"),
                .grid2(imageName: "avb2", text: "I Saw Good"),
                .grid2(imageName: "avb3", text: "All For Love"),
                .grid2(imageName: "avb4", text: "Kronos"),
            ]
        ),
        SectionViewModel(
            header: "Ленинград",
            cells: [
                .grid2(imageName: "l1", text: "Комон эврибади"),
                .grid2(imageName: "l2", text: "В Питере — пить"),
                .grid2(imageName: "l3", text: "Ч.П.Х."),
                .grid2(imageName: "l4", text: "Вояж"),
                .grid2(imageName: "l5", text: "Кабриолет"),
            ]
        ),
        SectionViewModel(
            header: "Уже прослушано",
            cells: [
                .carousel(
                    items: [
                        CarouselItem(imageName: "dummy", text: "Brassic TV-series"),
                        CarouselItem(imageName: "dummy", text: "THE ALBUM"),
                        CarouselItem(imageName: "dummy", text: "Mood booster"),
                        CarouselItem(imageName: "dummy", text: "That's The Spirit"),
                        CarouselItem(imageName: "dummy", text: "Up&Up"),
                        CarouselItem(imageName: "dummy", text: "The Saga of Wiz Khalifa (Deluxe)"),
                        CarouselItem(imageName: "dummy", text: "Любимые треки"),
                    ]
                ),
                .grid2(imageName: "l1", text: "Комон эврибади"),
                .grid2(imageName: "l3", text: "Ч.П.Х."),
                .grid2(imageName: "l4", text: "Вояж"),
                .grid2(imageName: "l5", text: "Кабриолет"),
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
        case .grid2(imageName: let imageName, text: let text):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "grid2cell", for: indexPath) as! Grid2Cell
            cell.imageView.image = UIImage(named: imageName)
            cell.label.text = text
            return cell
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
        case .grid2:
            let w = (view.bounds.width - l.sectionInset.left - l.sectionInset.right - l.minimumInteritemSpacing) / 2
            return CGSize(width: w, height: 60)
        case .carousel:
            let w = view.bounds.width - l.sectionInset.left - l.sectionInset.right
            return CGSize(width: w, height: 160)
        }
    }
}
