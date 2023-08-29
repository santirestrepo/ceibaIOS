//
//  UserController.swift
//  TestIOS
//
//  Created by Santiago Restrepo Marin on 28/08/23.
//

import Foundation
import SQLite

class UserController {
    static let shared = UserController()
    private let db: Connection?
    
    private init() {
        db = LocalPersistenceService.shared.getConnection()
        self.createTable()
    }
    
    private func createTable() {
        do {
            try db?.run(User.table.create(ifNotExists: true) { table in
                table.column(User.Columns.id, primaryKey: true)
                table.column(User.Columns.name)
                table.column(User.Columns.username)
                table.column(User.Columns.email)
                table.column(User.Columns.addressStreet)
                table.column(User.Columns.addressSuite)
                table.column(User.Columns.addressCity)
                table.column(User.Columns.addressZipcode)
                table.column(User.Columns.addressGeoLat)
                table.column(User.Columns.addressGeoLng)
                table.column(User.Columns.phone)
                table.column(User.Columns.website)
                table.column(User.Columns.companyName)
                table.column(User.Columns.companyCatchPhrase)
                table.column(User.Columns.companyBs)
            })
        } catch {
            print("Error creating user table: \(error)")
        }
    }
    
    func getAll(hasSyncedFromApi: Bool, completion: @escaping ([User]) -> Void) {
        let users: [User] = self.getUsers()
        if !users.isEmpty {
            completion(users)
        }
        
        if users.isEmpty && !hasSyncedFromApi {
            fetchUsersFromAPI {
                completion(self.getUsers())
            }
        }
    }
    
    private func getUsers() -> [User] {
        var users: [User] = []
        do {
            users = try db?.prepare(User.table).map { row in
                return User.fromRow(row: row)
            } ?? []
        } catch {
            print("Error fetching users from database: \(error)")
        }
        return users
    }
    
    private func fetchUsersFromAPI(completion: @escaping () -> Void) {
        NetworkService.shared.getUsers { users, error in
            if let error = error {
                print("Error fetching users from API: \(error)")
                completion()
                return
            }
            
            if let users = users {
                do {
                    try self.db?.transaction {
                        for user in users {
                            let setters = User.encode(user)
                            try self.db?.run(User.table.insert(or: .replace, setters))
                        }
                    }
                    DispatchQueue.main.async {
                        completion() // Call completion after updating database
                    }
                } catch {
                    print("Error performing bulk insert: \(error)")
                    DispatchQueue.main.async {
                        completion()
                    }
                }
            }
        }
    }

}
