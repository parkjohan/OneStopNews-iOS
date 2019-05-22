//
//  Helpers.swift
//  OneStopNews
//
//  Created by Renato Gamboa on 5/21/19.
//  Copyright © 2019 Johan Park. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    // Download image async
    func downloadImageFrom(link:String, contentMode: UIView.ContentMode) {
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
    
    // Make image rounded
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2)
        self.layer.masksToBounds = true
    }
}


