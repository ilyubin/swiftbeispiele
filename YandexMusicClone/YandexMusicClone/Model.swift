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

struct GridItem {
    let imageName: String
    let text: String
    let color: String
}

enum CellViewModel {
    case carousel(items: [CarouselItem])
    case grid(items: [GridItem])
}
