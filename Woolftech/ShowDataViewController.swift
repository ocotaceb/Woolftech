//
//  ShowDataViewController.swift
//  Woolftech
//
//  Created by Sudarshan Kadalazhi (Student) on 2/6/20.
//  Copyright © 2020 Orlando Cota. All rights reserved.
//

import UIKit
import Charts

class ShowDataViewController: UIViewController {

    @IBOutlet weak var lineChart: LineChartView!
    @IBOutlet weak var control: UISegmentedControl!
    var months: [String] = [""]
    var score: [Double] = [0.0]
    override func viewDidLoad() {
        super.viewDidLoad()
        if control.selectedSegmentIndex == 0
        {

            months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
            score = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
            print(months)
        }
        else if control.selectedSegmentIndex == 1
        {
            months = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "1", "12"]
            score = [10.0, 15.0, 2.0, 9.0, 4.0, 8.0, 12.0, 2.0, 17.0, 14.0, 5.0, 10.0]
        }
        setChart(dataPoints: months, values: score)
    }
    
    func setChart(dataPoints: [String], values: [Double])
    {
        lineChart.noDataText = "No Data can be found"
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y:values[i])
            dataEntries.append(dataEntry)
        }
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "Performance Score")
        let lineChartData = LineChartData( dataSet: lineChartDataSet)
        
        lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        lineChart.xAxis.granularity = 1
        lineChart.data = lineChartData
        
    }

    @IBAction func controlChanged(_ sender: Any) {
        if control.selectedSegmentIndex == 0
        {
            months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
            score = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
            print(months)
        }
        else if control.selectedSegmentIndex == 1
        {
           months = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "1", "12"]
           score = [10.0, 15.0, 2.0, 9.0, 4.0, 8.0, 12.0, 2.0, 17.0, 14.0, 5.0, 10.0]
        }
        setChart(dataPoints: months, values: score)
    }
}
