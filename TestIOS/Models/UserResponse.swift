//
//  UserResponse.swift
//  TestIOS
//
//  Created by Santiago Restrepo Marin on 28/08/23.
//

struct UserResponse: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
    
    enum CodingKeys: String, CodingKey {
        case id, name, username, email, address, phone, website, company
    }
    
    func toUser() -> User {
        return User(
            id: id,
            name: name,
            username: username,
            email: email,
            addressStreet: address.street,
            addressSuite: address.suite,
            addressCity: address.city,
            addressZipcode: address.zipcode,
            addressGeoLat: address.geo.lat,
            addressGeoLng: address.geo.lng,
            phone: phone,
            website: website,
            companyName: company.name,
            companyCatchPhrase: company.catchPhrase,
            companyBs: company.bs
        )
    }
}

struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}

struct Geo: Codable {
    let lat: String
    let lng: String
}

struct Company: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
}
