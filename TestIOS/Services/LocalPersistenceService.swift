//
//  LocalPersistenceService.swift
//  TestIOS
//
//  Created by Santiago Restrepo Marin on 28/08/23.
//

import Foundation
import SQLite

class LocalPersistenceService {
    static let shared = LocalPersistenceService()
    
    private let db: Connection?
    
    private init() {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            db = try Connection("\(path)/testios.db")
        } catch {
            db = nil
            NSLog("Unable to open database: \(error)")
        }
        
        
    }
    
    func getConnection() -> Connection? {
        return db
    }
}
