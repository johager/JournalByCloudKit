//
//  EntryController.swift
//  JournalByCloudKit
//
//  Created by James Hager on 4/11/22.
//

import Foundation
import CloudKit

class EntryController {
    
    static let shared = EntryController()
    
    var entries = [Entry]()
    
    private let privateDB = CKContainer.default().privateCloudDatabase
    
    // MARK: - CRUD
    
    func create(title: String, text: String, completion: @escaping (Result<Entry?, EntryError>) -> Void) {
        print("\(#function) - save entry")
        let entryRecord = CKRecord(entry: Entry(title: title, text: text))
        
        privateDB.save(entryRecord) { record, error in
            let cloudOperation = CloudOperation.save
            
            print("\(#function) - in privateDB.save completion")
            if let error = error {
                print("Error saving Entry: \(error.localizedDescription)\n---\n\(error)")
                return completion(.failure(.cloudError(cloudOperation, error)))
            }
            
            guard let record = record,
                  let entry = Entry(ckRecord: record)
            else { return completion(.failure(.error(cloudOperation))) }
            
            DispatchQueue.main.async {
                self.entries.append(entry)
                self.entries.sort { $1.timestamp < $0.timestamp }
            }
            
            completion(.success(entry))
        }
    }
    
    func fetch(completion: @escaping (Result<[Entry]?, EntryError>) -> Void) {
        let query = CKQuery(recordType: Entry.recordType, predicate: NSPredicate(value: true))
        
        privateDB.perform(query, inZoneWith: nil) { records, error in
            let cloudOperation = CloudOperation.query
            
            if let error = error {
                print("Error saving Entry: \(error.localizedDescription)\n---\n\(error)")
                return completion(.failure(.cloudError(cloudOperation, error)))
            }
            
            guard let records = records else { return completion(.failure(.error(cloudOperation))) }
            
            self.entries = records.compactMap { Entry(ckRecord: $0) }
            self.entries.sort { $1.timestamp < $0.timestamp }
            completion(.success(self.entries))
        }
    }
    
    func delete(entryAtIndex index: Int, completion: @escaping (Result<CKRecord.ID?, EntryError>) -> Void) {
        let entry = entries[index]
        
        privateDB.delete(withRecordID: entry.ckRecordID) { recordID, error in
            let cloudOperation = CloudOperation.delete
            
            if let error = error {
                print("Error saving Entry: \(error.localizedDescription)\n---\n\(error)")
                return completion(.failure(.cloudError(cloudOperation, error)))
            }
            
            guard let recordID = recordID else { return completion(.failure(.error(cloudOperation))) }
            self.entries.remove(at: index)
            
            completion(.success(recordID))
        }
    }
}
