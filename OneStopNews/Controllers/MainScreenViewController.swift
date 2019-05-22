//
//  ViewController.swift
//  OneStopNews
//
//  Created by Johan Park on 5/13/19.
//  Copyright © 2019 Johan Park. All rights reserved.
//

import UIKit
import Hero
import PageMenu
import Alamofire
import SwiftyJSON
import Lottie

class MainScreenViewController: UIViewController {
    
    var pageMenu: CAPSPageMenu?
    
    var osnAPI  = OSNNetworking()
    
    var articleDict = [String: [Article]]()
    
    var pastelColors = PastelColors()
    
    //TODO: - add activity loaders
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.black
        title = "One Stop News"
        
        // Get animation
        let animationView = AnimationView(name: "Newspaper-animation")
        navigationController?.view.addSubview(animationView)
        animationView.play()
        
        osnAPI.getAllCategoriesFromProvider(provider: Provider.NYT.rawValue, completion: { (articleDict) in
            //print(articleDict)
            print("Loading Articles Completed")
            
            // Update UI
            DispatchQueue.main.async {
                self.setupPageMenu(articleDict: articleDict)
            }
            animationView.stop()
            animationView.isHidden = true
        })
    }
}


//MARK: - PageMenu Controller

extension MainScreenViewController {
    
    // Create New View Controllers with Universal View Controller
    func newViewController(articleDict: [String: [Article]],category: String) -> UniversalTableViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tempVC = storyboard.instantiateViewController(withIdentifier: "UniversalTableView") as! UniversalTableViewController
        if let dict = articleDict[category] {
            tempVC.articleList = dict
        }
        tempVC.view.backgroundColor = UIColor.clear
        
        return tempVC
    }
    
    // Passing in articles to set up page
    func setupPageMenu(articleDict: [String: [Article]]) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Array of ViewControllers containing each page in PageMenu
        var controllerArray : [UIViewController] = []
        
        // Array of Pallet Colors
        var pastelColorsList = [pastelColors.Top, pastelColors.World, pastelColors.US, pastelColors.Business, pastelColors.Politics, pastelColors.Technology, pastelColors.Health, pastelColors.Entertainment, pastelColors.Travel, pastelColors.Latest]
        var pastelCount = 0
        
        // ******************* Latest VC ******************* //
        // Create ViewController for each page in pagemenu
        
        Category.allCases.forEach { (category) in
            
            let vc = newViewController(articleDict: articleDict, category: category.rawValue)
            vc.title = category.rawValue.uppercased()
            vc.pastelColorCombo = pastelColorsList[pastelCount]
            pastelCount += 1
            
            controllerArray.append(vc)
            
        }
        
        // last was 150.0 for menu height
        
        // Customize PageMenu
        let parameters: [CAPSPageMenuOption] = [
            .menuItemWidthBasedOnTitleTextWidth(true),
            .menuItemWidth(120.0),
            .scrollMenuBackgroundColor(.white),
            .viewBackgroundColor(.white),
            .selectionIndicatorColor(.black),
            .bottomMenuHairlineColor(.white),
            .menuHeight(65.0),
            .menuItemFont(UIFont(name: "HelveticaNeue-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16)),
            .centerMenuItems(true),
            .selectedMenuItemLabelColor(.black),
        ]

        for viewController in controllerArray {
            if let vc = viewController as? UniversalTableViewController {
                vc.tableView.reloadData()
            }
        }
        
        // Initialize page menu with controller array, frame, and optional parameters
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 85.0, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
        
        self.view.addSubview(pageMenu!.view)
    }
}

