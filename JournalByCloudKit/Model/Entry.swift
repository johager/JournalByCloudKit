//
//  Entry.swift
//  JournalByCloudKit
//
//  Created by James Hager on 4/11/22.
//

import Foundation
import CloudKit

class Entry {
    
    var title: String
    var text: String
    var timestamp: Date
    var ckRecordID: CKRecord.ID
    
    static let recordType = "Entry"
    static let titleKey = "title"
    static let textKey = "text"
    static let timestampKey = "timestamp"
    static let ckRecordIDKey = "ckRecordID"
    
    init(title: String, text: String, timestamp: Date = Date(), ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.title = title
        self.text = text
        self.timestamp = timestamp
        self.ckRecordID = ckRecordID
    }
    
    convenience init?(ckRecord: CKRecord) {
        guard let title = ckRecord[Entry.titleKey] as? String,
              let text = ckRecord[Entry.textKey] as? String,
              let timestamp = ckRecord[Entry.timestampKey] as? Date
        else { return nil }
        self.init(title: title, text: text, timestamp: timestamp, ckRecordID: ckRecord.recordID)
    }
    
    func update(title: String, text: String) {
        self.title = title
        self.text = text
    }
}

extension CKRecord {
    
    convenience init(entry: Entry) {
        self.init(recordType: Entry.recordType)
        self[Entry.titleKey] = entry.title
        self[Entry.textKey] = entry.text
        self[Entry.timestampKey] = entry.timestamp
    }
}
