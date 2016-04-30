//
//  Meal.swift
//  
//
//  Created by Duc Tran on 3/22/15.
//
//

import Foundation
import UIKit

// Represents a generic product. Need an image named "default"

class Meal : NSObject, NSCoding
{
    
    // MARK: Properties
    var id: Int
    var name: String
    var price: Float
    var photo: UIImage
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("meals")
    
    // MARK: Types
    struct PropertyKey {
        static let idKey = "id"
        static let nameKey = "name"
        static let priceKey = "price"
        static let photoKey = "photo"
    }
    
    // MARK: Initialization
    
    init?(id: Int, name: String, price: Float, photo: UIImage)
    {
        self.id = id
        self.name = name
        self.price = price
        self.photo = photo
        super.init()
        if name.isEmpty || id < 0 {
            return nil
        }
    }

    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(id, forKey: PropertyKey.idKey)
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeFloat(price, forKey: PropertyKey.priceKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)

    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let id = aDecoder.decodeIntegerForKey(PropertyKey.idKey)
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let price = aDecoder.decodeFloatForKey(PropertyKey.priceKey)
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as! UIImage
        
        // Must call designated initializer.
        self.init(id: id, name: name, price: price, photo: photo)
    }

}










