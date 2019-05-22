//
//  UniversalTableViewController.swift
//  OneStopNews
//
//  Created by Renato Gamboa on 5/21/19.
//  Copyright © 2019 Johan Park. All rights reserved.
//

import UIKit
import Pastel
import ViewAnimator
import DGElasticPullToRefresh

class UniversalTableViewController: UITableViewController{
    
    var articleList = [Article]()
    var pastelColorCombo = [UIColor]()
    
    let rotateAnimation = AnimationType.rotate(angle: CGFloat.pi/6)
    let fadeAnimation = AnimationType.zoom(scale: 0.1)
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        loadPastel()
        
        UIView.animate(views: self.tableView.visibleCells(in: 0), animations: [rotateAnimation, fadeAnimation], duration: 0.7)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPastel()
        setUpTableViewContraints()
        setUpTableViewRefresh()
    }
    
    
    func setUpTableViewContraints(){
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        self.tableView.contentInset = insets
    }
    
    func setUpTableViewRefresh(){
        // Initialize tableView
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            // Add your logic here
            // Do not forget to call dg_stopLoading() at the end
//            self?.tableView.dg_stopLoading()
            self!.stopLoading()
            }, loadingView: loadingView)
        
        tableView.dg_setPullToRefreshFillColor(UIColor.white)
        tableView.dg_setPullToRefreshBackgroundColor(UIColor.clear)
        
    }
    
    func stopLoading(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.dg_stopLoading()
            
            self.tableView.dg_removePullToRefresh()
            self.setUpTableViewRefresh()
        }
    }

    
    
    func loadPastel(){
        let pastelView = PastelView(frame: view.bounds)
        
        // Custom Direction
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight
        
        // Custom Duration
        pastelView.animationDuration = 2.0
        
        
        // Custom Color
        pastelView.setColors(pastelColorCombo)
        //        pastelView.setColors([UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
        //                              UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0),
        //                              UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
        //                              UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1.0),
        //                              UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0),
        //                              UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
        //                              UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0)])
        
        // Start gradient animation
        pastelView.startAnimation()
        
        self.tableView.backgroundView = pastelView
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! UniversalTableViewCell
        
        let article = articleList[indexPath.item]
        
        cell.article = article
        cell.title.text = article.title
        cell.summary.text = article.summary
        
        //cell.newsImage.image = UIImage(named: "placeholder")
        cell.newsImage.downloadImageFrom(link: article.image, contentMode: UIView.ContentMode.scaleAspectFit)
        
        // For word wrapping
//        cell.layoutIfNeeded()
//        let imageFrame = UIBezierPath(rect: cell.newsImage.frame)
//        cell.summary.textContainer.exclusionPaths = [imageFrame]
        
        cell.newsImage.setRounded()
        
        
        
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articleList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    

}
