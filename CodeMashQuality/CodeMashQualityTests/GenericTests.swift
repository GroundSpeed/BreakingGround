//
//  GenericTests.swift
//  CodeMashQuality
//
//  Created by Don Miller on 1/8/16.
//  Copyright © 2016 GroundSpeed. All rights reserved.
//

import XCTest

class GenericTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testOnePlusOneEqualsTwo() {
        XCTAssertEqual(1 + 1, 2, "one plus one should equal two")
    }
    
    func testDateFormatterPerformance() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .LongStyle
        dateFormatter.timeStyle = .ShortStyle
        
        let date = NSDate()
        
        measureBlock() {
            let string = dateFormatter.stringFromDate(date)
        }
    }
    
}
