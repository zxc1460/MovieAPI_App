//
//  Date.swift
//  API_Test
//
//  Created by Seok on 2020/12/19.
//

import Foundation

extension Date {
    static var yesterday: String {
        let date = Date().dayBefore
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko")
        dateFormatter.dateFormat = "yyyyMMdd"
        
        return dateFormatter.string(from: date)
    }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
}
