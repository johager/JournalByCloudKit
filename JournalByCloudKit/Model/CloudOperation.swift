//
//  CloudOperation.swift
//  JournalByCloudKit
//
//  Created by James Hager on 4/11/22.
//

import Foundation

enum CloudOperation: String, CustomStringConvertible {
    case query
    case save
    
    var description: String { rawValue }
}
