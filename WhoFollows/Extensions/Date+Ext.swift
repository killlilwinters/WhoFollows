//
//  Date+Ext.swift
//  WhoFollows
//
//  Created by Maks Winters on 10.03.2025.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        return formatted(.dateTime.day().month().year())
    }
}
