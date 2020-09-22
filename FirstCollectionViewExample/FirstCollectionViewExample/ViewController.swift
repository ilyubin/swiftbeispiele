//
//  ViewController.swift
//  FirstCollectionViewExample
//
//  Created by Lyubin Igor on 22.09.2020.
//  Copyright © 2020 ap. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    var array: [Int] = []

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for i in (1...20) {
            array.append(i)
        }
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        array.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NumberCell
        cell.label.text = "\(array[indexPath.row])"
        return cell
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row % 3 == 2 {
            return CGSize(width: collectionView.frame.size.width, height: 50)
        }
        let s = collectionView.frame.size.width / 2 - 20
        return CGSize(width: s, height: s)
    }
}
