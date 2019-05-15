//
//  Top Stories.swift
//  OneStopNews
//
//  Created by Johan Park on 5/14/19.
//  Copyright © 2019 Johan Park. All rights reserved.
//

import Foundation
import UIKit

class TopStoriesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //var articles = [Article]()
    
    var testData = ["hello","hello","hello","hello","hello","hello","hello","hello","hello","hello",]
    let cnnTopStoriesURL = "https://one-stop-news-api.herokuapp.com/cnn/?category=top-stories"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}

extension TopStoriesViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Article Cell", for: indexPath) as! TopStoriesTableViewCell
        cell.titleLabel.text = testData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
