//
//  Grid2Cell.swift
//  SpotifyClone
//
//  Created by Lyubin Igor on 02.10.2020.
//  Copyright © 2020 AP Organization. All rights reserved.
//

import UIKit

class Grid2Cell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .darkGray
        layer.cornerRadius = 8
        label.textColor = .white
    }
}
