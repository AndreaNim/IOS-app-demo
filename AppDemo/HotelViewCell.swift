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
        hotelName.text = hotel.title
        hotelLocation.text = hotel.address

    }
    
}
 
