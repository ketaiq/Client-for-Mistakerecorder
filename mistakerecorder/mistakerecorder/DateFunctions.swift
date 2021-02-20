//
//  DateFunctions.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/2/19.
//

import Foundation

let dateFormatter = DateFormatter()
let calendar = Calendar.current

class DateFunctions {
    static let functions = DateFunctions()
    
    func currentDate() -> String {
        let now = Date()
        return date2String(date: now)
    }
    
    func addDate(startDate: String, addition: Int) -> String {
        let date = string2Date(dateString: startDate)
        let resultDate = calendar.date(byAdding: .day, value: addition, to: date)!
        return date2String(date: resultDate)
    }
    
    func generateDatesOfMonth(givenDate: String) -> [Date] { // 获取给定日期所在月份的所有Date
        var dates = [Date]()
        var date = string2Date(dateString: givenDate)
        var dateComponents = calendar.dateComponents([.year, .month, .day, .timeZone], from: date)
        dateComponents.timeZone = TimeZone.current
        let startDateComponents = DateComponents(timeZone: TimeZone.current,year: dateComponents.year,
                                                 month: dateComponents.month,
                                                 day: 1) // 给定日期所在月份的第一天
        date = calendar.date(from: startDateComponents)!
        dateComponents = calendar.dateComponents([.year, .month, .day, .timeZone, .weekday], from: date)
        var i = 1 // 从周日开始
        while i < dateComponents.weekday! {
            dates.append(Date(timeIntervalSinceReferenceDate: 0))
            i = i + 1
        }
        let nextMonth = dateComponents.month! + 1
        while !isFirstDayOfNextMonth(givenDate: date, nextMonth: nextMonth) {
            dates.append(date)
            date = string2Date(dateString: addDate(startDate: date2String(date: date), addition: 1))
            dateComponents = calendar.dateComponents([.year, .month, .day, .timeZone], from: date)
        }
        return dates
    }
    
    func isValidDate(givenDate: Date) -> Bool {
        let dateComponents = calendar.dateComponents([.year], from: givenDate)
        if dateComponents.year! < 2021 {
            return false
        } else {
            return true
        }
    }
    
    func getDayFromDate(givenDate: Date) -> Int {
        let dateComponents = calendar.dateComponents([.day], from: givenDate)
        return dateComponents.day!
    }
    
    func getMonthFromDate(givenDate: Date) -> Int {
        let dateComponents = calendar.dateComponents([.month], from: givenDate)
        return dateComponents.month!
    }
    
    func getYearFromDate(givenDate: Date) -> Int {
        let dateComponents = calendar.dateComponents([.year], from: givenDate)
        return dateComponents.year!
    }
    
    private func isFirstDayOfNextMonth(givenDate: Date, nextMonth: Int) -> Bool {
        let dateComponents = calendar.dateComponents([.year, .month, .day, .timeZone], from: givenDate)
        if dateComponents.month == nextMonth && dateComponents.day == 1 {
            return true
        } else {
            return false
        }
    }
    
    private func string2Date(dateString: String) -> Date {
        dateFormatter.dateFormat = "M/d/yy"
        return dateFormatter.date(from: dateString)!
    }
    
    private func date2String(date: Date) -> String {
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: date)
    }
    
    
}
