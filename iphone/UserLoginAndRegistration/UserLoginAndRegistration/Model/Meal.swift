//
//  Meal.swift
//  
//
//  Created by Duc Tran on 3/22/15.
//
//

import Foundation
import UIKit

public enum MealRating
{
    case Unrated
    case Average
    case OK
    case Good
    case Brilliant
}

// Represents a generic product. Need an image named "default"

class Meal
{
    var name: String
    var price: String
    var photo: UIImage
    var rating: MealRating
    
    init(name: String, price: String, photo: String)
    {
        self.name = name
        self.price = price
        if let img = UIImage(named: photo) {
            self.photo = img
        } else {
            self.photo = UIImage(named: "default")!
        }
        rating = .Unrated
    }
}










