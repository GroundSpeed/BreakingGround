//
//  Products.swift
//  CodeMashQuality
//
//  Created by Don Miller on 1/7/16.
//  Copyright © 2016 GroundSpeed. All rights reserved.
//

import UIKit
import Parse

class Products {
    
    var objectId : String?
    var productId : Int?
    var photo : String?
    var photoFile : PFFile = PFFile()
    var photoImage : UIImage?
    var title : String?
    var flyer : String?
    var productDesc : String?
    var itemCode : String?
    var packagingOptions : String?
    var fragrances : String?
    var categories : String?
    var location : String?
    var msdsLink : String?
    var videoLink : String?
    var innerCase : Int?
    var masterCase : Int?
        
    func getAllProductsFromParse() -> Array<Products> {
        let query = PFQuery(className:"Products")
        var arrayProducts : Array<Products> = []
        
        do { let objects = try query.findObjects()
            for object in objects {
                self.objectId = object["objectId"] as? String
                self.productId = object["Id"] as? Int
                self.photoImage = object["PhotoImage"] as? UIImage
                self.title = object["Title"] as? String
                self.productDesc = object["Description"] as? String
                
                arrayProducts.append(self)
            }
        }
        catch let e as NSError { print("Parse load error: \(e)") }
        
        return arrayProducts
    }
    
}
