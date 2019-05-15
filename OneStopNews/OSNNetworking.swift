//
//  Networking.swift
//  OneStopNews
//
//  Created by Johan Park on 5/13/19.
//  Copyright © 2019 Johan Park. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class OSNNetworking {
    
    let cnnTopStoriesURL = "https://one-stop-news-api.herokuapp.com/cnn/?category=top-stories"
    
    func getArticles(url: String, parameters: [String:Any]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess {
                print("Successful! Got articles.")
                let articleJSON: JSON = JSON(response.result.value!)
                print(articleJSON)
                //self.updateArticles(json: articleJSON)
            } else {
                print("Error! \(String(describing: response.result.error))")
            }
        }
    }

    
}
