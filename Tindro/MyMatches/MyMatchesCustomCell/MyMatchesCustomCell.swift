//
//  MyMatchesCustomCell.swift
//  Tindro
//
//  Created by Salem Abdulla on 10/2/17.
//  Copyright © 2017 Salem Abdulla. All rights reserved.
//

import Foundation
import Firebase
import UIKit
class MyMatchesCustomCell: UITableViewCell {
    
    
    @IBOutlet weak var userName : UILabel!
    @IBOutlet weak var userAge : UILabel!
    @IBOutlet weak var userDescription: UILabel!
    
    @IBOutlet weak var likeLabel: UILabel!
    
    @IBOutlet weak var likeBtn: UIButton!
    
    @IBOutlet weak var unlikeBtn: UIButton!
    @IBOutlet weak var ImageCell: UIImageView!
//
    @IBAction func likePressed(_ sender: Any) {
        self.likeBtn.isEnabled = false
        let ref = Database.database().reference()
        let keyToPost = ref.child("UsersProfiles").childByAutoId().key

        ref.child("UsersProfiles").observeSingleEvent(of: .value, with: { (snapshot) in

            if let post = snapshot.value as? [String : AnyObject] {
                let updateLikes: [String : Any] = ["peopleWhoLike/\(keyToPost)" : Auth.auth().currentUser!.uid]
                ref.child("UsersProfiles").child("userid").updateChildValues(updateLikes, withCompletionBlock: { (error, reff) in

                    if error == nil {
                        ref.child("UsersProfiles").child("userid").observeSingleEvent(of: .value, with: { (snap) in
                            if let properties = snap.value as? [String : AnyObject] {
                                if let likes = properties["peopleWhoLike"] as? [String : AnyObject] {
                                    let count = likes.count
                                    self.likeLabel.text = "\(count) Likes"

                                    let update = ["likes" : count]
                                    ref.child("UsersProfiles").child("userid").updateChildValues(update)

                                    self.likeBtn.isHidden = true
                                    self.unlikeBtn.isHidden = false
                                    self.likeBtn.isEnabled = true
                                }
                            }
                        })
                    }
                })
            }


        })

        ref.removeAllObservers()
    }
    

    
    
    
    
    
    
    
    static let cellIdentifier = "MatchesCell"
    static let cellNib = UINib(nibName: "MyMatchesCustomCell", bundle: Bundle.main)
    
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
