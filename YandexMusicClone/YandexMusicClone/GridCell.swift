import UIKit

class GridCell: UICollectionViewCell {
    @IBOutlet
    private weak var collectionView: UICollectionView!
    private var viewModel: [GridItem] = []

    func configureGrid(with vm: [GridItem]) {
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
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
    }
}

extension GridCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = viewModel[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gridItemCell", for: indexPath) as! GridItemCell
        cell.imageView.image = UIImage(named: model.imageName)
        cell.text.text = model.text
//        cell.backgroundColor = UIColor(hexString: "6909A1")
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
}

extension GridCell: UICollectionViewDelegate {

}

extension GridCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let l = collectionViewLayout as! UICollectionViewFlowLayout
        let w = (bounds.width - l.minimumInteritemSpacing - 30) / 2
        return CGSize(width: w, height: w + 20 + 20)
    }
}
