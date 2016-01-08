//
//  RatesTableViewController.swift
//  Amortized
//
//  Created by Don Miller on 1/1/16.
//  Copyright © 2016 GroundSpeed. All rights reserved.
//

import UIKit

class RatesTableViewController: UITableViewController {

    @IBOutlet weak var thirtyYearFixedToday: UILabel!
    @IBOutlet weak var fifteenYearFixedToday: UILabel!
    @IBOutlet weak var fiveOneArmToday: UILabel!
    @IBOutlet weak var thirtyYearFixedLastWeek: UILabel!
    @IBOutlet weak var fifteenYearFixedLastWeek: UILabel!
    @IBOutlet weak var fiveOneArmLastWeek: UILabel!
    @IBOutlet var tblRates: UITableView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadTextFields()
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func loadTextFields() {
        
        let zillowRates : Dictionary<String, String> = ApiHelper().getRatesFromZillow()

        thirtyYearFixedToday.text = zillowRates["todayThirtyYearFixed"]
        fifteenYearFixedToday.text = zillowRates["todayFifteenYearFixed"]
        fiveOneArmToday.text = zillowRates["todayFiveOneARM"]
        thirtyYearFixedLastWeek.text = zillowRates["lastWeekThirtyYearFixed"]
        fifteenYearFixedLastWeek.text = zillowRates["lastWeekFifteenYearFixed"]
        fiveOneArmLastWeek.text = zillowRates["lastWeekFiveOneARM"]

    }
    
}
