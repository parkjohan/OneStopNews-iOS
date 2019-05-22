//
//  OSNSingleton.swift
//  OneStopNews
//
//  Created by Renato Gamboa on 5/22/19.
//  Copyright © 2019 Johan Park. All rights reserved.
//

import Foundation

final class OSNSingleton {
    
    private init() {
        
    }
    
    static let shared = OSNSingleton()
    
    var OSNGlobalList = [Article]()
    
    var currentGlobalList = [Article]()
    
}
