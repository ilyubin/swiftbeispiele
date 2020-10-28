//
//  CarouselCell.swift
//  SpotifyClone
//
//  Created by Lyubin Igor on 09.10.2020.
//  Copyright © 2020 AP Organization. All rights reserved.
//

import UIKit

class CarouselCell: UICollectionViewCell {
    @IBOutlet
    private weak var collectionView: UICollectionView!
    private var viewModel: [CarouselItem] = []
    
    func configure(with vm: [CarouselItem]) {
        viewModel = vm
        collectionView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        clipsToBounds = false
        contentView.clipsToBounds = false
        collectionView.clipsToBounds = false
    }
}

extension CarouselCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = viewModel[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselItemCell", for: indexPath) as! CarouselItemCell
        cell.imageView.image = UIImage(named: model.imageName)
        cell.label.text = model.text
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
}

extension CarouselCell: UICollectionViewDelegate {

}

extension CarouselCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let l = collectionViewLayout as! UICollectionViewFlowLayout
        let w = (bounds.width - 2 * l.minimumInteritemSpacing) / 3
        return CGSize(width: w, height: 160)
    }
}
