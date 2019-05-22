//
//  ArticlesCollectionViewCell.swift
//  OneStopNews
//
//  Created by Renato Gamboa on 5/22/19.
//  Copyright © 2019 Johan Park. All rights reserved.
//

import UIKit
import CarLensCollectionViewLayout
import WebKit

class ArticlesCollectionViewCell : CarLensCollectionViewCell, UIWebViewDelegate {
    
    static let identifier = "CollectionViewCell"
    
    
    override func awakeFromNib() {
        super .awakeFromNib()
        
        //webview.delegate = self
    }
    
    private var upperView: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 60)
        label.textAlignment = .center
        label.textColor = .white
        label.text = "Article"
        return label
    }()
    
    private var bottomView: UIView = {
        var bottomView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.backgroundColor = .white
        bottomView.layer.cornerRadius = 10
        
        let webview = UIWebView()




        
        let url = URL(string: "https://www.nytimes.com/2019/05/17/business/media/grumpy-cat-dead.html?emc=rss&partner=rss")
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
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure(topView: upperView, cardView: bottomView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
