import UIKit

class CarouselCell: UICollectionViewCell {
    @IBOutlet
    private weak var collectionView: UICollectionView!
    private var viewModel: [CarouselItem] = []

    func configureCarousel(with vm: [CarouselItem]) {
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

extension CarouselCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = viewModel[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselItemCell", for: indexPath) as! CarouselItemCell
        cell.imageView.image = UIImage(named: model.imageName)
        cell.text.text = model.text
        cell.subText.text = model.subText
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
}

extension CarouselCell: UICollectionViewDelegate {

}

extension CarouselCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let l = collectionViewLayout as! UICollectionViewFlowLayout
        let w = (bounds.width - l.minimumInteritemSpacing - 30) / 2
        return CGSize(width: w, height: w + 20 + 20)
    }
}
