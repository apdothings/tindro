//
//  myExtension.swift
//  eSponsorship
//
//  Created by Salem Abdulla on 9/27/17.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(from urlString: String) {
        
        //1. url
        //2 session, task, start
        guard let url = URL(string: urlString) else {
                return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print ("Error : \(error.localizedDescription)")
                return
            }
            if let data = data {
                //self.pokemonImageView.image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }
        task.resume()
    }
}
