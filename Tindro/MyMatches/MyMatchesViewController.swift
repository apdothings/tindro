//
//  MyMatchesViewController.swift
//  Tindro
//
//  Created by Salem Abdulla on 10/2/17.
//  Copyright © 2017 Salem Abdulla. All rights reserved.
//

import UIKit
import UIKit
import Foundation
import Firebase
import FirebaseAuth

class MyMatchesViewController: UIViewController {

    
    var posts: [UsersProfile] = []
    
    
    var databaseRef: DatabaseReference!
    var storageRef: StorageReference!
    
    
//    @IBAction func testButtonAction(sender: UIButton) {
//
//        print(sender.tag)
//
//        let cell = myMatchesTableView.cellForRow(at:
//            IndexPath(row: sender.tag, section: 0) as IndexPath) as! MyMatchesCustomCell
//
//        if cell.likeBtn.titleLabel?.text == "Cell \(sender.tag)" { //Your logic here. Check If button's image has "Liked Image than change Image to UnLiked Image"
//            print("liked")
////            cell.likeB.text = "\(sender.tag)"
//        }
//        else {
////            cell.likeButton.text = "Cell \(sender.tag)"
//            print("unliked")
//        }
//    }
    
    @IBOutlet weak var myMatchesTableView: UITableView!{
    didSet{
    myMatchesTableView.register(MyMatchesCustomCell.cellNib, forCellReuseIdentifier: MyMatchesCustomCell.cellIdentifier)
    myMatchesTableView.delegate = self
    myMatchesTableView.dataSource = self
    myMatchesTableView.estimatedRowHeight = 80
    myMatchesTableView.rowHeight = UITableViewAutomaticDimension

    }
}

override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "myMatches"
    
    fetchpost()
    
    myMatchesTableView.reloadData()
    
}


func fetchpost(){
    
    databaseRef = Database.database().reference()
    
    databaseRef.child("UsersProfiles").observe(.childAdded, with: { (snapshot) in
        
        guard let mypost = snapshot.value as? [String: Any]
            else {return}
        
        
        
        if let imageurl = mypost["imagePost"] as? String,
            let name = mypost["name"] as? String,
            let age = mypost["age"] as? String,
            let desc = mypost["Description"] as? String,
            let userid = mypost["userID"] as? String {
            
            
            //            let newPost = mypost(imageName: post)
            
            
            DispatchQueue.main.async {
                let newPost = UsersProfile(anID: userid, usersName: name, usersAge: age, usersImage: imageurl, usersDesc : desc)
                
                
                self.posts.append(newPost)
                self.myMatchesTableView.reloadData()
            }
            
        }
        
    })
    
}
}

extension MyMatchesViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//
//        let cell = myMatchesTableView.dequeueReusableCell(withIdentifier: MyMatchesCustomCell.cellIdentifier) as? MyMatchesCustomCell
        //Check If item is liked
//        if  {
//            
//            //Set image for like on button
//        }
//        else {
//            //Set image for unlike on button
//        }
//        cell?.likeBtn.tag = indexPath.row // This will assign tag to each button in tableView
////
////        return cell!
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myMatchesTableView.dequeueReusableCell(withIdentifier: MyMatchesCustomCell.cellIdentifier) as? MyMatchesCustomCell else {
            return UITableViewCell()
        }
        let post = posts[indexPath.row]
        
        //        cell.tournamentName.text = tournamentName
        //        cell.locationOfTournament.text = location
        //        cell.organizerName.text = organizerName
        //        cell.numberOfParticipants.text = participation
        
        cell.userName.text = post.name
        cell.userAge.text = post.age
        cell.userDescription.text = post.desc
        
        
        print(post.imageurl)
        cell.ImageCell.loadImage(from: post.imageurl)
        
        
        return cell
    }
    
}


