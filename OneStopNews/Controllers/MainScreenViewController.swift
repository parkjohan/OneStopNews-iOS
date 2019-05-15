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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPageMenu()
    }
}



//MARK: - PageMenu Controller

extension MainScreenViewController {
    
    func setupPageMenu() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        var controllerArray : [UIViewController] = []
        
        let topStoriesViewController = storyboard.instantiateViewController(withIdentifier: "TopStoriesViewController") as! TopStoriesViewController
        let businessViewController = storyboard.instantiateViewController(withIdentifier: "BusinessViewController") as! BusinessViewController
        topStoriesViewController.title = "Top Stories"
        businessViewController.title = "Business"
        
        controllerArray.append(topStoriesViewController)
        controllerArray.append(businessViewController)
        
        let parameters: [CAPSPageMenuOption] = [
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorWidth(0.0),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorPercentageHeight(0.0),
            .scrollMenuBackgroundColor(.black),
            .viewBackgroundColor(.white),
            .selectionIndicatorColor(.red),
            .bottomMenuHairlineColor(.white),
            .menuHeight(65.0),
            .menuItemWidth(self.view.frame.width/3),
            .menuItemFont(UIFont.systemFont(ofSize: 20)),
            .centerMenuItems(true),
            .selectedMenuItemLabelColor(.white),
            .unselectedMenuItemLabelColor(.white),
            .menuMargin(0.0)
        ]
        
        // Initialize page menu with controller array, frame, and optional parameters
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 80.0, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
        
        self.view.addSubview(pageMenu!.view)
    }
}

