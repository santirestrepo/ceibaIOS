//
//  User.swift
//  TestIOS
//
//  Created by Santiago Restrepo Marin on 28/08/23.
//

import Foundation
import SQLite

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let addressStreet: String
    let addressSuite: String
    let addressCity: String
    let addressZipcode: String
    let addressGeoLat: String
    let addressGeoLng: String
    let phone: String
    let website: String
    let companyName: String
    let companyCatchPhrase: String
    let companyBs: String
}

extension User {
    static var tableName: String {
        return "users"
    }
    
    static var table: Table {
        return Table(tableName)
    }
    
    static func fromRow(row: Row) -> User {
        return User(
            id: row[Columns.id],
            name: row[Columns.name],
            username: row[Columns.username],
            email: row[Columns.email],
            addressStreet: row[Columns.addressStreet],
            addressSuite: row[Columns.addressSuite],
            addressCity: row[Columns.addressCity],
            addressZipcode: row[Columns.addressZipcode],
            addressGeoLat: row[Columns.addressGeoLat],
            addressGeoLng: row[Columns.addressGeoLng],
            phone: row[Columns.phone],
            website: row[Columns.website],
            companyName: row[Columns.companyName],
            companyCatchPhrase: row[Columns.companyCatchPhrase],
            companyBs: row[Columns.companyBs]
        )
    }
    
    static func encode(_ user: User) -> [Setter] {
        return [
            Columns.id <- user.id,
            Columns.name <- user.name,
            Columns.username <- user.username,
            Columns.email <- user.email,
            Columns.addressStreet <- user.addressStreet,
            Columns.addressSuite <- user.addressSuite,
            Columns.addressCity <- user.addressCity,
            Columns.addressZipcode <- user.addressZipcode,
            Columns.addressGeoLat <- user.addressGeoLat,
            Columns.addressGeoLng <- user.addressGeoLng,
            Columns.phone <- user.phone,
            Columns.website <- user.website,
            Columns.companyName <- user.companyName,
            Columns.companyCatchPhrase <- user.companyCatchPhrase,
            Columns.companyBs <- user.companyBs
        ]
    }
    
    static func decode(row: Row) -> User {
        return User(
            id: row[Columns.id],
            name: row[Columns.name],
            username: row[Columns.username],
            email: row[Columns.email],
            addressStreet: row[Columns.addressStreet],
            addressSuite: row[Columns.addressSuite],
            addressCity: row[Columns.addressCity],
            addressZipcode: row[Columns.addressZipcode],
            addressGeoLat: row[Columns.addressGeoLat],
            addressGeoLng: row[Columns.addressGeoLng],
            phone: row[Columns.phone],
            website: row[Columns.website],
            companyName: row[Columns.companyName],
            companyCatchPhrase: row[Columns.companyCatchPhrase],
            companyBs: row[Columns.companyBs]
        )
    }

    struct Columns {
        static let id = Expression<Int>("id")
        static let name = Expression<String>("name")
        static let username = Expression<String>("username")
        static let email = Expression<String>("email")
        static let addressStreet = Expression<String>("address_street")
        static let addressSuite = Expression<String>("address_suite")
        static let addressCity = Expression<String>("address_city")
        static let addressZipcode = Expression<String>("address_zipcode")
        static let addressGeoLat = Expression<String>("address_geo_lat")
        static let addressGeoLng = Expression<String>("address_geo_lng")
        static let phone = Expression<String>("phone")
        static let website = Expression<String>("website")
        static let companyName = Expression<String>("company_name")
        static let companyCatchPhrase = Expression<String>("company_catchPhrase")
        static let companyBs = Expression<String>("company_bs")
    }
    
    static var example: User {
        return User(id: 1, name: "John Doe", username: "john.doe", email: "john@example.com", addressStreet: "123 Main St", addressSuite: "Apt 4B", addressCity: "Cityville", addressZipcode: "12345", addressGeoLat: "123.456", addressGeoLng: "-123.456", phone: "123456789", website: "www.example.com", companyName: "Example Inc", companyCatchPhrase: "Catchy phrase", companyBs: "Business stuff")
    }
}
