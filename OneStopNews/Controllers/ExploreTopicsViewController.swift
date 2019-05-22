//
//  ExploreTopicsViewController.swift
//  OneStopNews
//
//  Created by Johan Park on 5/13/19.
//  Copyright © 2019 Johan Park. All rights reserved.
//

import Foundation
import UIKit
import RAMReel

class ExploreTopicsViewController: UIViewController, UICollectionViewDelegate {
    
    var dataSource: SimplePrefixQueryDataSource!
    var ramReel: RAMReel<RAMCell, RAMTextField, SimplePrefixQueryDataSource>!
    
    var dataList = [String]()
    
    //TODO: - Set up notification to update list
    
    override func viewDidAppear(_ animated: Bool) {
        setUpRamReel()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        ramReel.view.removeFromSuperview()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setUpRamReel(){
        dataList = OSNSingleton.shared.OSNGlobalList.map { $0.title }
        print(dataList)
        dataSource = SimplePrefixQueryDataSource(dataList)
        ramReel = RAMReel(frame: view.bounds, dataSource: dataSource, placeholder: "Start by typing…", attemptToDodgeKeyboard: true) {
            print("Plain:", $0)
        }
        ramReel.hooks.append {
            let r = Array($0.reversed())
            let j = String(r)
            print("Reversed:", j)
        }
        
        view.addSubview(ramReel.view)
        ramReel.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    
    
    
    
    
}
