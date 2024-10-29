//
//  Date+Ext.swift
//  MessengerSwiftUI
//
//  Created by serhat on 29.10.2024.
//

import Foundation

extension Date {
    
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    
    private var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateFormat = "MM/dd/yy"
        return formatter
    }
    
    /// Returns the time of the date as a formatted string.
    /// - Returns: A string representing the time of the date in "HH:mm" format.
    private func timeString() -> String {
        return timeFormatter.string(from: self)
    }
    
    
    /// Returns the date as a formatted string.
    /// - Returns: A string representing the date in "MM/dd/yy" format.
    private func dateString() -> String {
        return dayFormatter.string(from: self)
    }
    
    
    /// Returns a string representation of the date as a timestamp, formatted according to relative timing.
    /// - Returns: A string formatted as "HH:mm" if the date is today, "Yesterday" if the date is yesterday, or "MM/dd/yy" otherwise.
    func timestampString() -> String {
        if Calendar.current.isDateInToday(self) {
            return timeString()
        } else if Calendar.current.isDateInYesterday(self) {
            return "Yesterday"
        } else {
            return dateString()
        }
    }
    
}
