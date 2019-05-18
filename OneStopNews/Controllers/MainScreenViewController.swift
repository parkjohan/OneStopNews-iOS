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
        
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.navigationBar.tintColor = UIColor.black
        title = "One Stop News"
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
        let firstVC = storyboard.instantiateViewController(withIdentifier: "CNN")
        firstVC.view.backgroundColor = UIColor.red
        
        let secondVC = UIViewController()
        secondVC.view.backgroundColor = UIColor.blue

        let thirdVC = UIViewController()
        thirdVC.view.backgroundColor = UIColor.green

        let fourthVC = UIViewController()
        fourthVC.view.backgroundColor = UIColor.purple
        
        // Add title for each ViewController page
        firstVC.title = "CNN"
        secondVC.title = "New York Times"
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
            .scrollMenuBackgroundColor(.black),
            .viewBackgroundColor(.white),
            .selectionIndicatorColor(.red),
            .bottomMenuHairlineColor(.white),
            .menuHeight(65.0),
            .menuItemFont(UIFont.systemFont(ofSize: 15)),
            .centerMenuItems(true),
            .selectedMenuItemLabelColor(.white),
        ]
        
        // Initialize page menu with controller array, frame, and optional parameters
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 85.0, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
        
        self.view.addSubview(pageMenu!.view)
    }
}

