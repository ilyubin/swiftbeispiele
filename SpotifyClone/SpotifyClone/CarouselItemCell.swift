//
//  CarouselItemCell.swift
//  SpotifyClone
//
//  Created by Lyubin Igor on 09.10.2020.
//  Copyright © 2020 AP Organization. All rights reserved.
//

import UIKit

class CarouselItemCell: UICollectionViewCell {
    @IBOutlet
    weak var label: UILabel!
    @IBOutlet
    weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 8
    }
}
