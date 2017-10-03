//
//  ProfileViewController.swift
//  Tindro
//
//  Created by Salem Abdulla on 10/2/17.
//  Copyright © 2017 Salem Abdulla. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func doneButton(_ sender: Any) {
            let mainStoryboard = UIStoryboard(name: "Home", bundle: nil)
            guard let targetVC = mainStoryboard.instantiateViewController(withIdentifier: "MymatchesHomeViewController") as? UINavigationController else { return }
//            self.dismiss(animated: true, completion: nil)
            self.present(targetVC, animated: true, completion: nil)
    }
    var posts: [UsersProfile] = []
    var databaseRef: DatabaseReference!
    var storageRef: StorageReference!
    var name: [UsersProfile]!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    
    @IBOutlet weak var ageTextField: UITextField!
    
    
    @IBOutlet weak var genderTextField: UITextField!
    
    
    @IBOutlet weak var descTextField: UITextField!
    
    @IBOutlet weak var imagePicked: UIImageView!
    
    
    
    //    let organizerName = "Monash University"
    //    let participation = "12 Teams"
    //    let location = "Cyberjaya Launchpad"
    
//    @IBAction func saveButton(_ sender: Any) {
//        
//        let mainStoryboard = UIStoryboard(name: "Home", bundle: nil)
//        guard let targetVC = mainStoryboard.instantiateViewController(withIdentifier: "MymatchesHomeViewController") as? UINavigationController else { return }
//        self.dismiss(animated: true, completion: nil)
//        self.present(targetVC, animated: true, completion: nil)
//        
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchpost()
        
//        self.nameTextField.text = "Monash Dota Competition"
//        self.nameTextField.text = name as? String
        
        
        
//        var ref = Database.database().reference()
//        var productRef = ref.child("UsersProfiles/name")
//
//        ref.observeSingleEvent(of: .value, with: { snapshot in
//            let m = snapshot.value as? String
//            self.nameTextField.text = m
//        })
      
        
        
//        self.nameTextField.text = name
//        self.ageTextField.text = age
//        self.descTextField.text = desc
        

     
    }
//    func signUpUser() {
//        guard let name = nameTextField.text,
//            let age = ageTextField.text,
//            let gender = genderTextField.text,
//            let desc = descTextField.text else {return}
//
//if name == "" || age == "" || gender == "" || desc == "" {
//            PromptHandler.showPrompt(title: "Missing input field", message: "Input field must be filled", in: self)
//            return
//
//        }
//
//}
    
    //open gallery
    @IBAction func GalleryViewTapped(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    //save
    @IBAction func SaveBtnTapped(_ sender: Any) {
        RegisterUser()
        saveToLibrary()
        let vc = UINavigationController(nibName: "MymatchesHomeViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true )
    }
    
    func saveToLibrary() {
        
        if imagePicked.image == nil {
            PromptHandler.showPrompt(title: "Missing Input Field", message: "Important Fields must be filled out", in: self)
            return
        }
        
        let imageData = UIImageJPEGRepresentation(imagePicked.image!, 0.6)
        let compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
        
        PromptHandler.showPrompt(title: "Photo Saved", message: "Your information is saved", in: self)
    }
    
    func uploadMedia(completion: @escaping (_ url: String?) -> Void) {
        let storageRef = Storage.storage().reference().child("myImage.jpeg")
        if let uploadData = UIImageJPEGRepresentation(self.imagePicked.image!, 0.5) {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print("error")
                    completion(nil)
                } else {
                    completion((metadata?.downloadURL()?.absoluteString)!)
                    // your uploaded photo url.
                }
            }
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imagePicked.image = image
        
        dismiss(animated:true, completion: nil)
    }
    
    func RegisterUser() {
        
        guard let name = nameTextField.text,
            let age = ageTextField.text,
            let gender = genderTextField.text,
            let desc = descTextField.text else {return}
        
        if name == "" || age == "" || gender == "" || desc == "" {
            PromptHandler.showPrompt(title: "Missing input field", message: "Input field must be filled", in: self)
            return
        }
        
        if imagePicked == nil{
            PromptHandler.showPrompt(title: "Missing Field", message: "Important Field Must Be Filled", in: self)
        }
        
        uploadMedia { (downloadURL) in
            if let url = downloadURL {
                
                let ref = Database.database().reference()
                let imagePost : String = url
                let postRef = Database.database().reference()
                
                guard let id = Auth.auth().currentUser?.uid else { return }
                
                let post : [String:Any] = ["name" : name, "userID": id, "age" : age, "gender" : gender,"Description" : desc, "imagePost" : imagePost]
                
                postRef.child("UsersProfiles").childByAutoId().setValue(post)
            }
        }
    }
    
    func fetchpost(){
        
        databaseRef = Database.database().reference()
        
        databaseRef.child("UsersProfiles").observe(.childAdded, with: { (snapshot) in
            
            guard let mypost = snapshot.value as? [String: Any]
                else {return}
            
            
            
            if let imageurl = mypost["imagePost"] as? String,
                let name = mypost["name"] as? String,
                let age = mypost["age"] as? String,
                let gender = mypost["gender"] as? String,
                let desc = mypost["desc"] as? String,
                let userid = mypost["userID"] as? String {
                
//                var userid : String = ""
//
//                var name : String = ""
//
//                var imageurl : String = ""
//
//                var age : String = ""
//
//                var desc : String = ""
                //            let newPost = mypost(imageName: post)
                
                
                DispatchQueue.main.async {
                    let newPost = UsersProfile(anID: userid,usersName: name,usersGender: gender, usersAge: age, usersImage : imageurl, usersDesc : desc)
                    
                    
                    self.posts.append(newPost)
//                    self.tournamentsTableView.reloadData()
                    
                    self.nameTextField.text = name
                    self.ageTextField.text = age
                    self.descTextField.text = desc
                }
                
            }
            
        })
        
    }
}




