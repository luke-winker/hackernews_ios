//
//  ArticleTableViewCell.swift
//  hackernews
//
//  Created by Winker,Luke on 5/31/19.
//  Copyright © 2019 Winker,Luke. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    // MARK: Properties

    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleTextView.isUserInteractionEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
