//
//  CarouselItemCell.swift
//  YandexMusicClone
//
//  Created by Lyubin Igor on 28.10.2020.
//  Copyright © 2020 AP Organization. All rights reserved.
//

import UIKit

class CarouselItemCell: UICollectionViewCell {
    @IBOutlet
    weak var imageView: UIImageView!
    @IBOutlet
    weak var text: UILabel!
    @IBOutlet
    weak var subText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 0
    }
}
