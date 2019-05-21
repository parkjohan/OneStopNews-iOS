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
        
        osnAPI.getAllCategoriesFromProvider(provider: Provider.CNN.rawValue, completion: { (articleDict) in
            //print(articleDict)
            print("Loading Articles Completed")
            
            // Update UI
            DispatchQueue.main.async {
                self.setupPageMenu(articleDict: articleDict)
            }
        })
        
    }
}


//MARK: - PageMenu Controller

extension MainScreenViewController {
    
    // Passing in articles to set up page
    func setupPageMenu(articleDict: [String: [Article]]) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Array of ViewControllers containing each page in PageMenu
        var controllerArray : [UIViewController] = []
        
        
        // ******************* Latest VC ******************* //
        // Create ViewController for each page in pagemenu
        let firstVC = storyboard.instantiateViewController(withIdentifier: "UniversalTableView") as! UniversalTableViewController
        firstVC.pastelColorCombo = pastelColors.Latest
        
        if let dict1 = articleDict["latest"] {
            firstVC.articleList = dict1
        }
        firstVC.view.backgroundColor = UIColor.clear
        
        
        
        // ******************* World VC ******************* //
        let secondVC = storyboard.instantiateViewController(withIdentifier: "UniversalTableView") as! UniversalTableViewController
        secondVC.pastelColorCombo = pastelColors.World
        if let dict2 = articleDict["world"] {
            secondVC.articleList = dict2
        }
        secondVC.view.backgroundColor = UIColor.clear
        
        
        // ******************* US VC ******************* //
        let thirdVC = storyboard.instantiateViewController(withIdentifier: "UniversalTableView") as! UniversalTableViewController
        thirdVC.pastelColorCombo = pastelColors.Latest
        if let dict3 = articleDict["us"] {
            thirdVC.articleList = dict3
        }
        thirdVC.view.backgroundColor = UIColor.clear
        

        let fourthVC = UIViewController()
        fourthVC.view.backgroundColor = UIColor.white
        
        // Add title for each ViewController page
        firstVC.title = "Latest"
        secondVC.title = "World News"
        thirdVC.title = "US News"
        fourthVC.title = "Politics"
        
        // Append the ViewController to the array to display in PageMenu
        controllerArray.append(firstVC)
        controllerArray.append(secondVC)
        controllerArray.append(thirdVC)
        controllerArray.append(fourthVC)
        
        // Customize PageMenu
        let parameters: [CAPSPageMenuOption] = [
            //.menuItemWidthBasedOnTitleTextWidth(true),
            .menuItemWidth(150.0),
            .scrollMenuBackgroundColor(.white),
            .viewBackgroundColor(.white),
            .selectionIndicatorColor(.black),
            .bottomMenuHairlineColor(.white),
            .menuHeight(65.0),
            .menuItemFont(UIFont.systemFont(ofSize: 15)),
            .centerMenuItems(true),
            .selectedMenuItemLabelColor(.black),
        ]
        
        firstVC.tableView.reloadData()
        secondVC.tableView.reloadData()
        
        // Initialize page menu with controller array, frame, and optional parameters
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 85.0, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
        
        self.view.addSubview(pageMenu!.view)
    }
}

