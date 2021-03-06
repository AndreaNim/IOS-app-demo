//
//  HotelViewCell.swift
//  AppDemo
//
//  Created by Andrea Perera on 11/12/20.
//  Copyright © 2020 Andrea Perera. All rights reserved.
//

import UIKit

class HotelViewCell: UITableViewCell {
    
    @IBOutlet weak var hotelImageView: UIImageView!
    
    @IBOutlet weak var hotelName: UILabel!
    
    @IBOutlet weak var hotelLocation: UILabel!
    
    
    func configure(hotel: Hotel) {
        makeRounded()
        hotelImageView.image=hotel.image
        hotelName.text = hotel.title
        hotelLocation.text = hotel.address
        
    }
    //round viewimage
    func makeRounded() {
        hotelImageView.contentMode = UIView.ContentMode.scaleAspectFill
        hotelImageView.layer.masksToBounds = false
        hotelImageView.layer.borderColor = UIColor.white.cgColor
        //This will change with corners of image and height/2 will make this circle shape
        hotelImageView.layer.cornerRadius = hotelImageView.frame.height/2
        hotelImageView.clipsToBounds = true
    }
    
}

