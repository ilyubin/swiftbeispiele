import Foundation

struct SectionViewModel {
    let header: String
    let cells: [CellViewModel]
}

struct CarouselItem {
    let imageName: String
    let text: String
    let subText: String
}

enum CellViewModel {
//    case grid2(imageName: String, text: String)
    case carousel(items: [CarouselItem])
}
