//
//  CarouselCell.swift
//  YandexMusicClone
//
//  Created by Lyubin Igor on 28.10.2020.
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
//        collectionView.delegate = self
//        collectionView.dataSource = self
        clipsToBounds = false
        contentView.clipsToBounds = false
        collectionView.clipsToBounds = false
    }
}
