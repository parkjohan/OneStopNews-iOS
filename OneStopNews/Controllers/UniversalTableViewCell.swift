//
//  UniversalTableViewCell.swift
//  OneStopNews
//
//  Created by Renato Gamboa on 5/21/19.
//  Copyright © 2019 Johan Park. All rights reserved.
//

import UIKit

class UniversalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var summary: UITextView!
    @IBOutlet weak var newsImage: UIImageView!
    
    
    
    var article: Article?
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
