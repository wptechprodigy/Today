//
//  Date+Today.swift
//  Today
//
//  Created by waheedCodes on 31/05/2022.
//

import Foundation

extension Date {

    var dayAndTimeText: String {
        let timeText = formatted(date: .omitted, time: .shortened)
        if Locale.current.calendar.isDateInToday(self) {
            let timeFormat = NSLocalizedString("Today at %@", comment: "Today at time format string")
            return String(format: timeFormat, timeText)
        } else {
            let dateText = formatted(.dateTime.month(.abbreviated).day())
            let dateAndTimeFormat = NSLocalizedString("%@ at %@", comment: "Date and time format string")
            return String(format: dateAndTimeFormat, dateText, timeText)
        }
    }

    var daytext: String {
        if Locale.current.calendar.isDateInToday(self) {
            return NSLocalizedString(
                "Today",
                comment: "Today due date description")
        } else {
            return formatted(.dateTime
                                .month()
                                .day()
                                .weekday(.wide))
        }
    }

    var dayMonthAndYearText: String {
        let dayText = formatted(.dateTime.day(.twoDigits))
        let monthText = formatted(.dateTime.month(.abbreviated))
        let yearText = formatted(.dateTime.year(.defaultDigits))

        let dayMonthAndYearFormat = NSLocalizedString("%@ %@ %@", comment: "Day, month and yime format string")

        return String(format: dayMonthAndYearFormat, dayText, monthText, yearText)
    }
}
