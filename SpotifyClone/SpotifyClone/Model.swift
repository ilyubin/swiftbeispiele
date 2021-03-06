//
//  Model.swift
//  SpotifyClone
//
//  Created by Lyubin Igor on 02.10.2020.
//  Copyright © 2020 AP Organization. All rights reserved.
//

import Foundation

struct SectionViewModel {
    let header: String
    let cells: [CellViewModel]
}

struct CarouselItem {
    let imageName: String
    let text: String
}

enum CellViewModel {
    case grid2(imageName: String, text: String)
    case carousel(items: [CarouselItem])
}
