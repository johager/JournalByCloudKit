//
//  EntryError.swift
//  JournalByCloudKit
//
//  Created by James Hager on 4/11/22.
//

import Foundation

enum EntryError: LocalizedError {
    
    case cloudError(CloudOperation, Error)
    case errorCreating
    case errorFetching
    
    var errorDescription: String? {
        switch self {
        case .cloudError(let cloudOperation, let error):
            return "Cloud \(cloudOperation) error: \(error.localizedDescription)\n---\n\(error)"
        case .errorCreating:
            return "Error creating Entry"
        case .errorFetching:
            return "Error fetching Entries"
        }
    }
}
