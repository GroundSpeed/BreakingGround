//
//  ParsePeformanceTests.swift
//  CodeMashQuality
//
//  Created by Don Miller on 1/7/16.
//  Copyright © 2016 GroundSpeed. All rights reserved.
//

import XCTest
import Parse
import Bolts
@testable import CodeMashQuality

class ParsePeformanceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParsePerformanceOnMainThread() {
        // This is an example of a performance test case.
        self.measureBlock {
            self.checkParseIsSetup()
        }
    }
    
    func checkParseIsSetup() {
        let testObject = PFObject(className: "TestObject")
        testObject["foo"] = "bar"
        
        do { try testObject.save()
            print("Object has been saved.")
        }
        catch let e as NSError { print("Parse save error: \(e)") }
    }
    

    func testParsePerformanceGettingProducts() {
        // This is an example of a performance test case.
        self.measureBlock {
            self.checkParsePullingData()
        }
    }
    
    func checkParsePullingData() {
        let query = PFQuery(className:"Products")
        
        do { let objects = try query.findObjects()
            for object in objects {
                print(object.objectId)
            }
        }
        catch let e as NSError { print("Parse load error: \(e)") }
    }
    
    func testGettingRatesCollection() {
        let arrayProducts : Array<Products> = Products().getAllProductsFromParse()
        
        XCTAssert(arrayProducts.count > 0, "\(arrayProducts.count) should be greater than zero")
    }
 
}
