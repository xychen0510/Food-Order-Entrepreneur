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
    
    init(titled: String, description: String, imageName: String)
    {
        self.name = titled
        self.price = description
        if let img = UIImage(named: imageName) {
            photo = img
        } else {
            photo = UIImage(named: "default")!
        }
        rating = .Unrated
    }
}










