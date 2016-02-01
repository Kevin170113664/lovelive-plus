import UIKit

class CalculatorCalendar {
    
    private var calendar: NSCalendar?
    private var year: Int?
    private var month: Int?
    private var day: Int?
    private var hour: Int?
    
    init () {
        calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        year = calendar!.components(.Year, fromDate: NSDate()).year
        month = calendar!.components(.Month, fromDate: NSDate()).month
        day = calendar!.components(.Day, fromDate: NSDate()).day
        hour = calendar!.components(.Hour, fromDate: NSDate()).hour
    }
    
    func getYear() -> Int {
        return year!
    }
    
    func getMonth() -> Int {
        return month!
    }
    
    func getDay() -> Int {
        return day!
    }
    
    func getHour() -> Int {
        return hour!
    }
}
