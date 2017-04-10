//
//  TrendingChartViewController.swift
//  ComparisonGuru
//
//  Created by Wenzhong Zheng on 2017-04-10.
//  Copyright © 2017 Wenzhong. All rights reserved.
//

import UIKit
import Charts

class TrendingChartViewController: UIViewController {

    var product:Product!
    
    @IBOutlet weak var chartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setChart()
    }

    func setChart(){
        var dataEntries:[ChartDataEntry] = []
        var dateValue = [String]()
        if let trends = product.trends{
            for i in 0..<trends.count {
                let dataEntry = ChartDataEntry(x: Double(i), y: trends[i].price)
                dataEntries.append(dataEntry)
                
                dateValue.append(convertDateFormater(date: trends[i].date))
            }
            
            let data = LineChartData()
            let chartDataSet = LineChartDataSet(values: dataEntries, label: "Sale Price")
            data.addDataSet(chartDataSet)
            
            chartView.data = data
            chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dateValue)
            chartView.xAxis.granularity = 1
            chartView.xAxis.labelPosition = .bottom
        }
        
    }

    func convertDateFormater(date: String) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        guard let date = dateFormatter.date(from: date) else {
            assert(false, "no date from string")
            return ""
        }
        
        dateFormatter.dateFormat = "y/MMM/d"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let timeStamp = dateFormatter.string(from: date)
        print(timeStamp)
        return timeStamp
    }
}











