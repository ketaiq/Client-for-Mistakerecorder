//
//  DateFunctions.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/2/19.
//

import Foundation

let dateFormatter = DateFormatter()
let calendar = Calendar.current

class DateArray: ObservableObject {
    @Published var dates: [Date]
    
    init(dates: [Date]) {
        self.dates = dates
    }
}

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
        let startDateComponents = DateComponents(timeZone: TimeZone.current, year: dateComponents.year,
                                                 month: dateComponents.month,
                                                 day: 1) // 给定日期所在月份的第一天
        date = calendar.date(from: startDateComponents)!
        dateComponents = calendar.dateComponents([.year, .month, .day, .timeZone, .weekday], from: date)
        var i = 1 // 从周日开始
        while i < dateComponents.weekday! { // 填补空缺日期
            dates.append(Date(timeIntervalSinceReferenceDate: TimeInterval(arc4random_uniform(100000))))
            i = i + 1
        }
        let nextMonth = dateComponents.month! % 12 + 1
        while !isFirstDayOfNextMonth(givenDate: date, nextMonth: nextMonth) {
            dates.append(date)
            date = string2Date(dateString: addDate(startDate: date2String(date: date), addition: 1))
            dateComponents = calendar.dateComponents([.year, .month, .day, .timeZone], from: date)
        }
        return dates
    }
    
    func replaceDatesWithNextMonth(givenDateArray: DateArray) { // 获取给定日期下一月份的所有Date
        var date = givenDateArray.dates[10]
        var dateComponents = calendar.dateComponents([.year, .month, .day, .timeZone], from: date)
        let nextMonth = dateComponents.month! % 12 + 1
        dateComponents.timeZone = TimeZone.current
        while dateComponents.month! != nextMonth && dateComponents.day != 1 {
            date = string2Date(dateString: addDate(startDate: date2String(date: date), addition: 1))
            dateComponents = calendar.dateComponents([.year, .month, .day, .timeZone], from: date)
        }
        let newDates = generateDatesOfMonth(givenDate: date2String(date: date))
        if givenDateArray.dates.count >= newDates.count {
            var i = 0
            while i < newDates.count {
                givenDateArray.dates[i] = newDates[i]
                i = i + 1
            }
            while i < givenDateArray.dates.count {
                givenDateArray.dates[i] = Date(timeIntervalSinceReferenceDate: TimeInterval(arc4random_uniform(100000))) // 多余的日期置为无效日期
                i = i + 1
            }
        } else {
            var i = 0
            while i < givenDateArray.dates.count {
                givenDateArray.dates[i] = newDates[i]
                i = i + 1
            }
            while i < newDates.count {
                givenDateArray.dates.append(newDates[i])
                i = i + 1
            }
        }
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
    
    func getDayFromDate(givenDate: String) -> Int {
        let date = string2Date(dateString: givenDate)
        let dateComponents = calendar.dateComponents([.day], from: date)
        return dateComponents.day!
    }
    
    func getMonthFromDate(givenDate: Date) -> Int {
        let dateComponents = calendar.dateComponents([.month], from: givenDate)
        return dateComponents.month!
    }
    
    func getMonthFromDate(givenDate: String) -> Int {
        let date = string2Date(dateString: givenDate)
        let dateComponents = calendar.dateComponents([.month], from: date)
        return dateComponents.month!
    }
    
    func getYearFromDate(givenDate: Date) -> Int {
        let dateComponents = calendar.dateComponents([.year], from: givenDate)
        return dateComponents.year!
    }
    
    func getYearFromDate(givenDate: String) -> Int {
        let date = string2Date(dateString: givenDate)
        let dateComponents = calendar.dateComponents([.year], from: date)
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
