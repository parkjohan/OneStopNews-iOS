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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.black
        title = "One Stop News"
        
        // Call Network
        //osnAPI.getArticlesFromProvider(provider: Provider.CNN.rawValue, category: Category.Latest.rawValue)
        
        osnAPI.getAllCategoriesFromProvider(provider: Provider.CNN.rawValue, completion: { (articleDict) in
            print(articleDict)
        })
        
        setupPageMenu()
    }
}


//MARK: - PageMenu Controller

extension MainScreenViewController {
    
    func setupPageMenu() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Array of ViewControllers containing each page in PageMenu
        var controllerArray : [UIViewController] = []
        
        // Create ViewController for each page in pagemenu
        let firstVC = storyboard.instantiateViewController(withIdentifier: "UniversalTableView") as! UniversalTableViewController
        firstVC.pastelColorCombo = pastelColors.Latest
        firstVC.view.backgroundColor = UIColor.clear
        
        let secondVC = storyboard.instantiateViewController(withIdentifier: "UniversalTableView") as! UniversalTableViewController
        firstVC.pastelColorCombo = pastelColors.World
        secondVC.view.backgroundColor = UIColor.clear

        let thirdVC = UIViewController()
        thirdVC.view.backgroundColor = UIColor.white

        let fourthVC = UIViewController()
        fourthVC.view.backgroundColor = UIColor.white
        
        // Add title for each ViewController page
        firstVC.title = "Latest"
        secondVC.title = "World News"
        thirdVC.title = "Huffington Post"
        fourthVC.title = "NBC"
        
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
        
        // Initialize page menu with controller array, frame, and optional parameters
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 85.0, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
        
        self.view.addSubview(pageMenu!.view)
    }
}

