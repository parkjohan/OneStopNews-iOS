//
//  ArticlesCollectionViewController.swift
//  OneStopNews
//
//  Created by Renato Gamboa on 5/22/19.
//  Copyright © 2019 Johan Park. All rights reserved.
//

import UIKit
import CarLensCollectionViewLayout

private let reuseIdentifier = "Cell"

class ArticlesCollectionViewController: UICollectionViewController {
    
    var articles = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        collectionView.backgroundColor = .lightGray
        collectionView.register(ArticlesCollectionViewCell.self, forCellWithReuseIdentifier: ArticlesCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.collectionViewLayout = CarLensCollectionViewLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticlesCollectionViewCell.identifier, for: indexPath) as? ArticlesCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
}
