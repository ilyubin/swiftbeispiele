//
//  NumberCell.swift
//  FirstCollectionViewExample
//
//  Created by Lyubin Igor on 22.09.2020.
//  Copyright © 2020 ap. All rights reserved.
//

import UIKit

class NumberCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 2
        layer.borderColor = UIColor.gray.cgColor
    }
}
