//
//  UsersProfile.swift
//  Tindro
//
//  Created by Salem Abdulla on 10/2/17.
//  Copyright © 2017 Salem Abdulla. All rights reserved.
//

import Foundation
import UIKit

class UsersProfile {
    
    var userid : String = ""
    
    var name : String = ""
    
    var imageurl : String = ""
    
    var age : String = ""
    
    var desc : String = ""

    
    init() {}
    
    init(anID: String, usersName: String, usersAge: String, usersImage: String, usersDesc : String) {
        
        userid = anID
        imageurl = usersImage
        name = usersName
        age = usersAge
        desc = usersDesc
    
    }
}
