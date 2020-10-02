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
        SectionViewModel(header: "Добрый утро", cells: [
                .grid2(imageName: "dummy", text: "Brassic"),
                .grid2(imageName: "dummy", text: "This is bring me the horizon"),
                .grid2(imageName: "dummy", text: "Brassic"),
                .grid2(imageName: "dummy", text: "Brassic"),
                .grid2(imageName: "dummy", text: "Brassic"),
        ]),
        SectionViewModel(header: "Добрый день", cells: [
                .grid2(imageName: "dummy", text: "Brassic"),
                .grid2(imageName: "dummy", text: "This is bring me the horizon"),
                .grid2(imageName: "dummy", text: "Brassic"),
                .grid2(imageName: "dummy", text: "Brassic"),
                .grid2(imageName: "dummy", text: "Brassic"),
        ]),
        SectionViewModel(header: "Добрый вечер", cells: [
                .grid2(imageName: "dummy", text: "Brassic"),
                .grid2(imageName: "dummy", text: "This is bring me the horizon"),
                .grid2(imageName: "dummy", text: "Brassic"),
                .grid2(imageName: "dummy", text: "Brassic"),
                .grid2(imageName: "dummy", text: "Brassic"),
        ]),
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
        }
    }
}
