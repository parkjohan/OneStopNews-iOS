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
}
