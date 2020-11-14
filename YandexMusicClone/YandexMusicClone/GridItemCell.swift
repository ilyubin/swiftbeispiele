import UIKit

class GridItemCell: UICollectionViewCell {
    @IBOutlet
    weak var imageView: UIImageView!
    @IBOutlet
    weak var text: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 0
    }
}
