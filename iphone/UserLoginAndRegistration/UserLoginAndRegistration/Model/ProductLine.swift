//
//  ProductLine.swift
//  TableViewDemo
//
//  Created by Duc Tran on 3/22/15.
//  Copyright (c) 2015 Duc Tran. All rights reserved.
//
//  Here we have several Apple product lines:
//  (1) iDevices: Apple Watch, iPad, iPhone, iOS
//  (2) Mac: MacBook, MacBook Pro with Retina Display, MacBook Air, iMac
//           Mac Pro, MacBook Pro, Mac Mini, Display, Airport Extreme,
//           AirPort Time Capsule, AirPort Express, Magic Trackpad
//           Magic Mouse, Apple Keyboard, Apple Battery Charger
//  (3) Software: OS X, iLife, iWork, Logic Pro X, Final Cut Pro X, Aperture
//  (4) iPod: Apple TV, iPod nano, iPod shuffle, iPod touch, iTunes
//  (5) Services: iCloud, Apple Pay

import Foundation

class ProductLine
{
    // Variables
    var name: String            // name of the product line
    var products: [Product]     // all products in the line
    
    init(named: String, includeProducts: [Product])
    {
        name = named
        products = includeProducts
    }
    
    class func productLines() -> [ProductLine]
    {
        return [self.iDevices(), self.mac(), self.software(), self.iPod(), self.iCloudAndApplePay()]
    }
    
    // Private methods
    
    private class func iDevices() -> ProductLine {
        //  (1) iDevices: Apple Watch, iPad, iPhone, iOS
        var products = [Product]()
        
        products.append(Product(titled: "苦瓜牛肉", description: "$9.9", imageName: "Image"))
        products.append(Product(titled: "凉拌三丝", description: "$9.9", imageName: "Image-2"))
        products.append(Product(titled: "四川凉面", description: "$9.9", imageName: "Image-1"))
        products.append(Product(titled: "手工大包子", description: "$9.9", imageName: "Image-3"))
        products.append(Product(titled: "炸酱面", description: "$9.9", imageName: "Image-4"))
        products.append(Product(titled: "羊肉烩面", description: "$9.9", imageName: "Image-5"))
        products.append(Product(titled: "羊肉泡馍", description: "$9.9", imageName: "Image-6"))
        products.append(Product(titled: "盐水鸭", description: "$9.9", imageName: "Image-7"))
        
        return ProductLine(named: "iDevices", includeProducts: products)
    }
    
    //  (2) Mac: MacBook, MacBook Pro with Retina Display, MacBook Air, iMac
    //           Mac Pro, MacBook Pro, Mac Mini, Display, Airport Extreme,
    //           AirPort Time Capsule, AirPort Express, Magic Trackpad
    //           Magic Mouse, Apple Keyboard, Apple Battery Charger
    
    private class func mac() -> ProductLine
    {
        var products = [Product]()
        
        products.append(Product(titled: "MacBook", description: "The thinnest and lightest Mac ever with every component meticulously redesigned to create a Mac that is just two pounds and 13.1 mm thin. ", imageName: "macbook.tif"))
        products.append(Product(titled: "MacBook Pro 13 inch", description: "MacBook Pro features the latest dual-core and quad-core processors, and faster graphics to deliver the perfect combination of pro performance and extreme portability.", imageName: "macbook-pro-13.tif"))
        products.append(Product(titled: "MacBook Pro with Retina Display", description: "A stunning high-resolution display, an amazing thin and light design, and the latest technology to power through the most demanding projects.", imageName: "macbook-pro-retina.tif"))
        products.append(Product(titled: "MacBook Air", description: "All day battery life, fourth generation Intel Core processors with faster graphics, 802.11ac Wi-Fi and flash storage that is up to 45 percent faster than the previous generation.", imageName: "macbook-air.tif"))
        products.append(Product(titled: "iMac", description: "The 27-inch iMac with Retina 5K display features a breathtaking 14.7 million pixel display so text appears sharper than ever, videos are unbelievably lifelike.", imageName: "imac-5k.tif"))
        products.append(Product(titled: "Mac Pro", description: "Designed around a revolutionary unified thermal core, the Mac Pro introduces a completely new pro desktop architecture and design that is optimized for performance inside and out.", imageName: "mac-pro.tif"))
        products.append(Product(titled: "Mac Mini", description: "With its sleek aluminum design, a removable bottom panel for easy access to memory, and a space-saving built-in power supply, Mac mini is pretty incredible.", imageName: "mac-mini.tif"))
        products.append(Product(titled: "Displays", description: "The 27-inch Apple LED Cinema Display supersizes your view with an incredible 2560-by-1440 resolution.", imageName: "display.tif"))
        products.append(Product(titled: "Airport Extreme", description: "Featuring 802.11ac Wi-Fi for up to three times faster performance.", imageName: "airport-extreme.tif"))
        
        return ProductLine(named: "Mac", includeProducts: products)
    }
    
    //  (3) Software: OS X, iLife, iWork, Logic Pro X, Final Cut Pro X, Aperture
    
    private class func software() -> ProductLine
    {
        var products = [Product]()
        
        products.append(Product(titled: "OS X", description: "Built on a rock-solid UNIX foundation, OS X is engineered to take full advantage of the technologies in every new Mac.", imageName: "os-x.tif"))
        products.append(Product(titled: "iLife", description: "Do more with movies and music than you ever thought possible.", imageName: "ilife.tif"))
        products.append(Product(titled: "iWork", description: " iWork is the easiest way to create great-looking documents, spreadsheets, and presentations. ", imageName: "iwork.tif"))
        products.append(Product(titled: "Logic Pro X", description: "Logic Pro X, the most advanced version of Logic Pro to date, with a new interface designed for pros.", imageName: "logic-pro-x.tif"))
        products.append(Product(titled: "Final Cut Pro X", description: "A revolutionary new version of the world’s most popular Pro video editing software which completely reinvents video editing.", imageName: "final-cut-pro-x.tif"))
        products.append(Product(titled: "Aperture", description: "Featuring revolutionary new technologies and a pioneering user interface with a beautiful design that honors the rich tradition of precision watchmaking.", imageName: "aperture.tif"))
        
        return ProductLine(named: "Software", includeProducts: products)
    }
    
    //  (4) iPod: Apple TV, iPod nano, iPod shuffle, iPod touch, iTunes
    
    private class func iPod() -> ProductLine
    {
        var products = [Product]()
        
        products.append(Product(titled: "iPod nano", description: "The thinnest iPod ever featuring a 2.5-inch Multi-Touch display; convenient navigation buttons; built-in Bluetooth for wireless listening; and the iPod nano comes in seven gorgeous colors.", imageName: "ipod-nano.tif"))
        products.append(Product(titled: "iPod shuffle", description: "Crafted from a single piece of aluminium and polished to a beautiful shine, iPod shuffle feels solid, sleek and durable.", imageName: "ipod-shuffle.tif"))
        products.append(Product(titled: "iPod touch", description: "Featuring a brilliant 4-inch Retina display; a 5-megapixel iSight camera with 1080p HD video recording.", imageName: "ipod-touch.tif"))
        products.append(Product(titled: "iTunes", description: "A free application for your Mac or PC, iTunes organizes and plays your digital music and video on your computer.", imageName: "itunes.tif"))
        products.append(Product(titled: "Apple TV", description: "Access to tons of great HD content in a tiny package. Enjoy blockbuster movies, TV shows, live sports and news, your music, photos, and more — right on your high-definition TV.", imageName: "apple-tv.tif"))
        
        return ProductLine(named: "iPod and iTunes", includeProducts: products)
    }
    
    //  (5) Services: iCloud, Apple Pay
    
    private class func iCloudAndApplePay() -> ProductLine
    {
        var products = [Product]()
        
        products.append(Product(titled: "iCloud", description: "The thinnest iPod ever featuring a 2.5-inch Multi-Touch display; convenient navigation buttons; built-in Bluetooth for wireless listening; and the iPod nano comes in seven gorgeous colors.", imageName: "icloud.tif"))
        products.append(Product(titled: "Apple Pay", description: "A breakthrough set of free new cloud services that work seamlessly with applications on your iPhone®, iPad®, iPod touch®, Mac® or PC to automatically and wirelessly store your content in iCloud and automatically and wirelessly push it to all your devices. ", imageName: "apple-pay.tif"))
        
        return ProductLine(named: "iCloud and Apple Pay", includeProducts: products)
    }
}













