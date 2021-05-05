//
//  StringExtension.swift
//  MovieBrowser
//
//  Created by Colin Smith on 5/3/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

extension String {
    func formatDateString() -> String {
       var array = self.split(separator: "-", maxSplits: 2, omittingEmptySubsequences: true)
        if array.count > 2 {
            
            switch array[1] {
            case "01": array[1] = "January"
            case "02": array[1] = "February"
            case "03": array[1] = "March"
            case "04": array[1] = "April"
            case "05": array[1] = "May"
            case "06": array[1] = "June"
            case "07": array[1] = "July"
            case "08": array[1] = "August"
            case "09": array[1] = "September"
            case "10": array[1] = "October"
            case "11": array[1] = "November"
            case "12": array[1] = "December"
            default: array[1] = "--"
            }
            let year = String(array[0])
            let month = String(array[1])
            let day = String(array[2])
            return "\(month) \(day), \(year)"
        }
        return ""
    }
}


