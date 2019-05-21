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
    
    // Get articles for using url(String) and parameters.
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
    
    
    
    
    
    // Retrive a list of articles from server based on provider and category
    // Wait for completion
    func getArticlesFromProvider(provider: String, category: String, completion : @escaping ([Article])->()){
        
        let url = "https://one-stop-news-api.herokuapp.com/" + provider + "/?category=" + category
        
        var articleList: [Article] = []
            
        Alamofire.request(url, method: .get, parameters: nil).responseJSON { (response) in
            if response.result.isSuccess {
                //print("Successful! Got articles.")
                let articleJSON: JSON = JSON(response.result.value!)
                
               // Traverse to JSON
                for (_,item) in articleJSON {
                    let title = item["title"].string
                    let summary = item["summary"].string
                    let url = item["url"].string
                    let datePublshed = item["datePublished"].string
                    let image = item["image"].string
                    
                    // Create new Article object
                    let article = Article(
                        title: title ?? "",
                        summary: summary ?? "",
                        url: url ?? "",
                        datePublished: datePublshed ?? "",
                        image: image ?? ""
                        )
                    
                    // Add article to list
                    articleList.append(article)
                    
                }
                completion(articleList)
                
                //self.updateArticles(json: articleJSON)
            } else {
                print("Error! \(String(describing: response.result.error))")
            }
        }
    }
    
    
    
    
    
    // Return a dictionary of articles for a specific category
    func getAllCategoriesFromProvider(provider: String,completion : @escaping ([String: [Article]])->()) {
        
        var articleDict = [String: [Article]]()
        
        var count = 0
        // Iterate through all cases
        Category.allCases.forEach { (category) in
            
            // Get articles and wait for completion
            getArticlesFromProvider(provider: provider, category: category.rawValue, completion: { (articles) in
                
                //print(category.rawValue)
                //print(articles)
                
                // add to dictionary
                articleDict[category.rawValue] = articles
                
                //print("\n\n\n")
                
                //Increment total count
                count += 1
                
                if count == Category.allCases.count {
                    completion(articleDict)
                }
            })
        }
        
        
        
    }
    
}
