//
//  Date+String.swift
//  YSBase
//
//  Created by unitree on 2024/1/2.
//  Copyright © 2024 unitree.lee. All rights reserved.
//

import Foundation

public enum My_TimeEnum {
    case week(Int)
    case day(Int)
    case hour(Int)
    case minute(Int)
    case secend_Int(Int)
    case secend_Intervsl(TimeInterval)

    func getTimeInterval() -> TimeInterval{
        switch self {
        case .week(let num):
            return TimeInterval(num * 7 * 24 * 60 * 60)
        case .day(let num):
            return TimeInterval(num * 24 * 60 * 60)
        case .hour(let num):
            return TimeInterval(num * 60 * 60)
        case .minute(let num):
            return TimeInterval(num * 60)
        case .secend_Int(let num):
            return TimeInterval(num)
        case .secend_Intervsl(let num):
            return num
        }
    }
}

extension String{
    /// "yyyy-MM-dd HH:mm:ss"  ->   Date()  字符串转时间
    public func toDate(_ dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> Date?{
        let str:String = self
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let date = formatter.date(from: str)
        return date
    }
    
    /// "yyyy-MM-dd HH:mm:ss"  ->  1348747434  字符串转时间戳
    public func toTimeInterval(_ dateFormat:String? = "yyyy-MM-dd HH:mm:ss") -> TimeInterval {
        if self.isEmpty {
            return 0
        }
        let format = DateFormatter.init()
        format.dateStyle = .medium
        format.timeStyle = .short
        if dateFormat == nil {
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }else{
            format.dateFormat = dateFormat
        }
        let date = format.date(from: self)
        let d = date!.timeIntervalSince1970
        return d
    }
    
    
    /// 转变日期字符串的样式
    public func changeDateStrFormate(fromFormate:String = "yyyy-MM-dd HH:mm:ss",toFormate:String = "yyyy-MM-dd") -> String{
        if self.count == 0 {
            return ""
        }
        let date = self.toDate(fromFormate)
        let s = date?.toString(toFormate)
        return s!
    }
}

extension Date {
    /// 默认 yyyy-MM-dd HH:mm:ss
    public func toString(_ dateFormat:String="yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: self)
        return date
    }
    
    public func toTimeInterval() -> TimeInterval {
        return self.timeIntervalSince1970
    }

    public var yearString:String{
        return toString("yyyy")
    }
    
    public var monthString:String{
        return toString("MM")
    }
    
    public var dayString:String{
        return toString("dd")
    }
    
    public var hourString:String{
        return toString("HH")
    }
    
    public var minuteString:String{
        return toString("mm")
    }
    
    public var secendString:String{
        return toString("ss")
    }
    
    public var weekend:Int{
        let interval = Int(self.timeIntervalSince1970) + NSTimeZone.local.secondsFromGMT()
        let days = Int(interval/86400) // 24*60*60
        let weekday = ((days + 4)%7+7)%7
        return weekday == 0 ? 7 : weekday
    }
    
    // 是否是今天
    public var isToday: Bool{
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        return format.string(from: self) == format.string(from: Date())
    }
    
    // 是否是昨天
    public var isYesterday: Bool{
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let yesterday = Date().addTime(.day(-1))
        return format.string(from: self) == format.string(from: yesterday)
    }

    static func date(from string:String, formate:String) -> Date?{
        let formatter = DateFormatter()
        formatter.dateFormat = formate
        let date = formatter.date(from: string)
        return date
    }
    
    public func addTime(_ time:My_TimeEnum) -> Date {
        let t = self.timeIntervalSince1970 + time.getTimeInterval()
        return Date.init(timeIntervalSince1970: t)
    }
    
    ///返回星期几
    public func getweekDayString() ->String{
        let comps = self.weekend
        var str = ""
        if comps == 1 {
            str = "周一"
        }else if comps == 2 {
            str = "周二"
        }else if comps == 3 {
            str =  "周三"
        }else if comps == 4 {
            str =  "周四"
        }else if comps == 5 {
            str =  "周五"
        }else if comps == 6 {
            str =  "周六"
        }else if comps == 7 {
            str =  "周日"
        }
        return str
    }
    
    ///返回第几周
    public func getWeek() -> Int{
        guard let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian) else {
            return 1
        }
        let components = calendar.components([.weekOfYear,.weekOfMonth,.weekday,.weekdayOrdinal], from: self)
        //今年的第几周
        var weekOfYear = components.weekOfYear!
        
        //这个月第几周
        let weekOfMonth = components.weekOfMonth!
        //周几
//        let weekday = components.weekday!
        //这个月第几周
//        let weekdayOrdinal = components.weekdayOrdinal!
        if weekOfYear == 1 && weekOfMonth != 1 {
            weekOfYear = 53
        }
        return weekOfYear
    }
    
    public func daysBetweenDate(_ toDate:Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: self, to: toDate)
        return components.day ?? 0
    }
    
}


