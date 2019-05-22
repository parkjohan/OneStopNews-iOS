//
//  ArticleModel.swift
//  OneStopNews
//
//  Created by Johan Park on 5/15/19.
//  Copyright © 2019 Johan Park. All rights reserved.
//

import Foundation

struct Article: Hashable {
    
    var title: String
    var summary: String
    var url: String
    var datePublished: String
    var image: String
    
    // Will be able to find unique articles to prevent repetition in search
    var hashValue: Int {
        return (title).hashValue
    }
    
}

func == (lhs:Article, rhs:Article) -> Bool {
    return lhs.title == rhs.title
}
