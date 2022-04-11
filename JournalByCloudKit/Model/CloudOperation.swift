//
//  CloudOperation.swift
//  JournalByCloudKit
//
//  Created by James Hager on 4/11/22.
//

import Foundation

enum CloudOperation: String, CustomStringConvertible {
    case save
    case query
    case update
    case delete
    
    var description: String { rawValue }
}
