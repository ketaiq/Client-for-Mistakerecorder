//
//  DateFunctions.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/2/19.
//

import Foundation

class DateFunctions {
    static let functions = DateFunctions()
    
    func currentDate() -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: now)
    }
    
    func addDate(startDate: String, addition: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yy"
        let date = dateFormatter.date(from: startDate)!
        let resultDate = Calendar.current.date(byAdding: .day, value: addition, to: date)!
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: resultDate)
    }
}
