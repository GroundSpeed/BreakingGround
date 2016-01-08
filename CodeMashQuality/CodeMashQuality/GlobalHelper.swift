//
//  GlobalHelper.swift
//  Amortized
//
//  Created by Don Miller on 1/3/16.
//  Copyright © 2016 GroundSpeed. All rights reserved.
//

import UIKit

class GlobalHelper: NSObject {
    
    static let kApiKey = "X1-ZWz1f3t3bvl4i3_1brbp"
    let kPostEndpoint = "https://www.zillow.com/webservice/GetRateSummary.htm?zws-id=\(kApiKey)&output=json"


    func getMonthlyPayment(amount: Float, downPayment: Float, term: Float, interestRate: Float, lblPayment: UILabel) -> UILabel {
        // A = payment Amount per period
        // P = initial Principal (loan amount)
        // r = interest rate per period
        // n = total number of payments or periods
        
        let principal : Float = amount - downPayment
        let payments = term*12
        let rate = interestRate/12/100
        let amount = calculatPMTWithRatePerPeriod(rate, numberOfPayments: payments, loanAmount: principal, futureValue: 0, type: 0)
        
        if (isnan(amount) || isinf(amount))
        {
            lblPayment.font = UIFont.boldSystemFontOfSize(18)
            lblPayment.textColor = UIColor.redColor()
            lblPayment.text = "You must enter all required fields.";
        }
        else
        {
            lblPayment.font = UIFont(name: "Avenir Next", size: 28)
            lblPayment.textColor = UIColor.whiteColor()
            lblPayment.text = String(format: "%.02f", amount)
        }
        
        return lblPayment
    }
    
    func calculatPMTWithRatePerPeriod (ratePerPeriod: Float, numberOfPayments: Float, loanAmount: Float, futureValue: Float, type: Float) -> Float {
        
        var q : Float
        
        q = pow(1 + ratePerPeriod, numberOfPayments)
        
        let returnValue = (ratePerPeriod * (futureValue + (q * loanAmount))) / ((-1 + q) * (1 + ratePerPeriod * (type)))
        
        return returnValue
        
    }
}

extension String {
    func toPercent() -> String {
        return String.localizedStringWithFormat("%.2f%%", Float(self)!)
    }
}
