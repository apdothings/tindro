//
//  MyMatchesCustomCell.swift
//  Tindro
//
//  Created by Salem Abdulla on 10/2/17.
//  Copyright © 2017 Salem Abdulla. All rights reserved.
//

import Foundation
import UIKit
class MyMatchesCustomCell: UITableViewCell {
    
    @IBOutlet weak var userName : UILabel!
    @IBOutlet weak var userAge : UILabel!
    @IBOutlet weak var userDescription: UILabel!
  
    
    @IBOutlet weak var ImageCell: UIImageView!
    
    static let cellIdentifier = "MatchesCell"
    static let cellNib = UINib(nibName: "myMatchesTableView", bundle: Bundle.main)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.borderWidth = 5
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.cornerRadius = 0
    }
    
}
