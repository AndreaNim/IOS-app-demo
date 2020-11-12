//
//  Hotel.swift
//  AppDemo
//
//  Created by Andrea Perera on 11/12/20.
//  Copyright © 2020 Andrea Perera. All rights reserved.
//

import Foundation
import UIKit
class Hotel{
    
    var hotelID:Int
    var image : UIImage
    var title : String
    var address : String
    var description:String
    
    init(hotelID:Int,image : UIImage,title : String,address : String,description:String) {
        self.hotelID=hotelID
        self.image=image
        self.title=title
        self.address=address
        self.description=description
       
    }
    
    
}
 
