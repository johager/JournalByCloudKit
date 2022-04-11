//
//  Date+.swift
//  JournalByCloudKit
//
//  Created by James Hager on 4/11/22.
//

import Foundation

extension Date {
    
    var string: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: self)
    }
}
