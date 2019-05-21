//
//  Categories.swift
//  OneStopNews
//
//  Created by Renato Gamboa on 5/21/19.
//  Copyright © 2019 Johan Park. All rights reserved.
//

import Foundation

// Case Iterable allows traveral through all cases
enum Category: String,CaseIterable {
    
    case TopStories = "top-stories"
    case WorldNews = "world"
    case USNews = "us"
    case Business = "business"
    case Politics = "politics"
    case Technology = "technology"
    case Health = "health"
    case Entertainment = "entertainment"
    case Travel = "travel"
    case Latest = "latest"
    
}
