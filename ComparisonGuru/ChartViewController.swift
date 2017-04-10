//
//  ChartViewController.swift
//  ComparisonGuru
//
//  Created by Wenzhong Zheng on 2017-04-10.
//  Copyright © 2017 Wenzhong. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController {

    @IBOutlet weak var chartView: LineChartView!
    var months:[String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec","Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0,20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        
        
        
//        self.chartView.gridBackgroundColor = NSUIColor.white
        setChart(dataPoints: months, values: unitsSold)
    }

    func setChart(dataPoints:[String], values:[Double]){
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let data = LineChartData()
        let chartDataSet = LineChartDataSet(values: dataEntries, label: "Units Sold")
        
        data.addDataSet(chartDataSet)
        
        chartView.data = data
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        chartView.xAxis.granularity = 1
    }
    
}

extension ChartViewController: IValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return String(format: "%.0f", months[dataSetIndex])
    }
}
