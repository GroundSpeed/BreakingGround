//
//  ApiHelper.swift
//  Amortized
//
//  Created by Don Miller on 1/3/16.
//  Copyright © 2016 GroundSpeed. All rights reserved.
//

import UIKit

class ApiHelper {

    func getRatesFromZillow() -> Dictionary<String, String> {
        var results : Dictionary<String, String> = Dictionary()

        print("URL \(GlobalHelper().kPostEndpoint)")
        
        let url = NSURL(string: GlobalHelper().kPostEndpoint)!
        let session = NSURLSession.sharedSession()
        
        // Create the request
        let request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // Make the POST call and handle it in a completion handler
        session.dataTaskWithRequest(request, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            do
            {
                if let postString = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary
                {
                    print("output: \(postString)")
                    let response : Dictionary<String, AnyObject> = postString["response"] as! Dictionary<String, AnyObject>
                    let today : Dictionary<String, String> = response["today"] as! Dictionary<String, String>
                    let todayRate = Rates()
                    todayRate.thirtyYearFixed = today["thirtyYearFixed"]!.toPercent()
                    todayRate.fifteenYearFixed = today["fifteenYearFixed"]!.toPercent()
                    todayRate.fiveOneARM = today["fiveOneARM"]!.toPercent()
                    
                    results["todayThirtyYearFixed"] = todayRate.thirtyYearFixed
                    results["todayFifteenYearFixed"] = todayRate.fifteenYearFixed
                    results["todayFiveOneARM"] = todayRate.thirtyYearFixed
                    
                    let lastWeek : Dictionary<String, String> = response["lastWeek"] as! Dictionary<String, String>
                    let lastWeekRate = Rates()
                    lastWeekRate.thirtyYearFixed = lastWeek["thirtyYearFixed"]!.toPercent()
                    lastWeekRate.fifteenYearFixed = lastWeek["fifteenYearFixed"]!.toPercent()
                    lastWeekRate.fiveOneARM = lastWeek["fiveOneARM"]!.toPercent()

                    results["lastWeekThirtyYearFixed"] = lastWeekRate.thirtyYearFixed
                    results["lastWeekFifteenYearFixed"] = lastWeekRate.fifteenYearFixed
                    results["lastWeekFiveOneARM"] = lastWeekRate.thirtyYearFixed
                }
                else
                {
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    // No error thrown, but not NSDictionary
                    print("NODICT: Error could not parse JSON: \(jsonStr)")
                }
            }
            catch let parseError
            {
                print(parseError)
                // Log the error thrown by `JSONObjectWithData`
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("CATCH: Error could not parse JSON: '\(jsonStr)'")
            }
        }).resume()
        sleep(1)
        
        return results
    }
}
