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
    
    //TODO: - Get place holder image
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.black
        title = "One Stop News"
        
        // Get animation
        let animationView = AnimationView(name: "Newspaper-animation")
        
        let size = 450

        animationView.frame = CGRect(x: 0, y: 0, width: size, height: size)
        animationView.center.x = self.view.center.x
        animationView.center.y = self.view.center.y
        
        self.view.addSubview(animationView)
        

        
        animationView.play(fromProgress: 0,
                           toProgress: 1,
                           loopMode: LottieLoopMode.loop,
                           completion: { (finished) in
                            if finished {
                                print("Animation Complete")
                            } else {
                                print("Animation cancelled")
                            }
        })
        
        osnAPI.getAllCategoriesFromProvider(provider: Provider.NYT.rawValue, completion: { (articleDict) in
            //print(articleDict)
            print("Loading Articles Completed")
            
            // Update UI
            DispatchQueue.main.async {
                self.setupPageMenu(articleDict: articleDict)
            }
            
            // Append global list contents without duplicates
            for articleList in articleDict {
                OSNSingleton.shared.OSNGlobalList.append(contentsOf: articleList.value)
                var list = Array(Set(OSNSingleton.shared.OSNGlobalList))
                OSNSingleton.shared.OSNGlobalList = list
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

