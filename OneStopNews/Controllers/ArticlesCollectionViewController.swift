//
//  ArticlesCollectionViewController.swift
//  OneStopNews
//
//  Created by Renato Gamboa on 5/22/19.
//  Copyright © 2019 Johan Park. All rights reserved.
//

import UIKit
import CarLensCollectionViewLayout
import WebKit

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

        
        cell.topViewLabel = articles[indexPath.row].title
        cell.bottomViewLink = articles[indexPath.row].url
        
       // cell.configure(topView: createTopView(title: articles[indexPath.row].title), cardView: createBottomView(urlString: articles[indexPath.row].url))

        return cell
    }
    
    func createTopView(title: String)->UIView {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = .white
        label.text = title
        return label
    }
    
    func createBottomView(urlString: String)-> UIView{
        var bottomView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.backgroundColor = .white
        bottomView.layer.cornerRadius = 10
        
        let webview = UIWebView()
        
        
        let url = URL(string: urlString)
        let urlRequest = URLRequest(url: url!)
        // webview.delegate = self
        webview.loadRequest(urlRequest)
        
        bottomView.addSubview(webview)
        
        webview.translatesAutoresizingMaskIntoConstraints = false
        webview.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor).isActive = true
        webview.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor).isActive = true
        webview.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        webview.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
        webview.layer.cornerRadius = 10
        
        return bottomView
    }
    
}
