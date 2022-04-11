//
//  EntryError.swift
//  JournalByCloudKit
//
//  Created by James Hager on 4/11/22.
//

import Foundation

enum EntryError: LocalizedError {
    
    case cloudError(CloudOperation, Error)
    case error(CloudOperation)
    
    var errorDescription: String? {
        switch self {
        case .cloudError(let cloudOperation, let error):
            return "Cloud \(cloudOperation) error: \(error.localizedDescription)\n---\n\(error)"
        case .error(let cloudOperation):
            return "Error completing \(cloudOperation) operation."
        }
    }
}
