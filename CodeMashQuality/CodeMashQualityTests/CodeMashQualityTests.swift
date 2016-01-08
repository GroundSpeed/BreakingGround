//
//  CodeMashQualityTests.swift
//  CodeMashQualityTests
//
//  Created by Don Miller on 1/7/16.
//  Copyright © 2016 GroundSpeed. All rights reserved.
//

import XCTest
@testable import CodeMashQuality

class CodeMashQualityTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetPayment() {
        let amount: Float = 100000.00
        let downPayment: Float = 1000.00
        let interestRate: Float = 5.0
        let term: Float = 30
        let label : UILabel = UILabel()
        
        let result = GlobalHelper().getMonthlyPayment(amount, downPayment: downPayment, term: term, interestRate: interestRate, lblPayment: label)
        
        XCTAssert(result.text == "531.45", "\(result.text) should equal 531.45")
        XCTAssert(result.textColor == UIColor.whiteColor(), "\(result.textColor) should be white")
    }
    
    func testGetPaymentBadNumber() {
        let amount: Float = 0
        let downPayment: Float = 0
        let interestRate: Float = 0
        let term: Float = 0
        let label : UILabel = UILabel()
        
        let result = GlobalHelper().getMonthlyPayment(amount, downPayment: downPayment, term: term, interestRate: interestRate, lblPayment: label)
        
        XCTAssert(result.text == "You must enter all required fields.", "\(result.text) should read You must enter all required fields.")
        XCTAssert(result.textColor == UIColor.redColor(), "\(result.textColor) should be red")
    }
    
    
    func testCalculatePayment() {
        let amount: Float = 100000.00
        let downPayment: Float = 1000.00
        let interestRate: Float = 5.0
        let term: Float = 30
        
        let principal : Float = amount - downPayment
        let payments = term*12
        let rate = interestRate/12/100
        
        var result = GlobalHelper().calculatPMTWithRatePerPeriod(rate, numberOfPayments: payments, loanAmount: principal, futureValue: 0.0, type: 0.0)
        result = round(100*result)/100  //Round to two decimal places
        XCTAssert(result == 531.45, "\(result) should equal 531.45")
        
    }
    
    func testJsonCall() {
        let zillowRates : Dictionary<String, String> = ApiHelper().getRatesFromZillow()
        
        XCTAssert(zillowRates.count == 6, "\(zillowRates.count) should include 6 records")
    }
    
    func testRatesModel() {
        let rates = Rates()
        
        rates.thirtyYearFixed = "2.00"
        rates.fifteenYearFixed = "1.00"
        rates.fiveOneARM = "1.50"
        
        XCTAssertNotNil(rates.thirtyYearFixed)
        XCTAssertNotNil(rates.fifteenYearFixed)
        XCTAssertNotNil(rates.fiveOneARM)
    }
    
    func testRatesModelForPercentSign() {
        let rates = Rates()
        
        rates.thirtyYearFixed = "2.00".toPercent()
        rates.fifteenYearFixed = "1.00".toPercent()
        rates.fiveOneARM = "1.50".toPercent()
        
        XCTAssert(rates.thirtyYearFixed.characters.last! == "%", "\(rates.thirtyYearFixed) should end with a percent")
        XCTAssert(rates.fifteenYearFixed.characters.last! == "%", "\(rates.thirtyYearFixed) should end with a percent")
        XCTAssert(rates.fiveOneARM.characters.last! == "%", "\(rates.thirtyYearFixed) should end with a percent")
    }
    
    func testPerformanceZillowConnection() {
        self.measureBlock {
            self.callAsynchronousZillowConnection()
        }
    }
    
    func callAsynchronousZillowConnection() {
        
        let URL = NSURL(string: GlobalHelper().kPostEndpoint)!
        let expectation = expectationWithDescription("GET \(URL)")
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(URL) { data, response, error in
            XCTAssertNotNil(data, "data should not be nil")
            XCTAssertNil(error, "error should be nil")
            
            if let HTTPResponse = response as? NSHTTPURLResponse,
                responseURL = HTTPResponse.URL,
                MIMEType = HTTPResponse.MIMEType
            {
                XCTAssertEqual(responseURL.absoluteString, URL.absoluteString, "HTTP response URL should be equal to original URL")
                XCTAssertEqual(HTTPResponse.statusCode, 200, "HTTP response status code should be 200")
                XCTAssertEqual(MIMEType, "application/json", "HTTP response content type should be application/json")
            } else {
                XCTFail("Response was not NSHTTPURLResponse")
            }
            
            expectation.fulfill()
        }
        task.resume()
        waitForExpectationsWithTimeout(task.originalRequest!.timeoutInterval) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            task.cancel()
        }
    }
    
}
