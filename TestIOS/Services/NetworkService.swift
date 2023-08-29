//
//  NetworkService.swift
//  TestIOS
//
//  Created by Santiago Restrepo Marin on 28/08/23.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    let baseUrl = "https://jsonplaceholder.typicode.com"
    
    private init() {}
    
    func getUsers(completion: @escaping ([User]?, Error?) -> Void) {
        performRequest(path: "users", parameters: nil) { (userResponse: [UserResponse]?, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let userResponse = userResponse else {
                completion(nil, nil)
                return
            }
            
            let users = userResponse.map { $0.toUser() }
            completion(users, nil)
        }
    }
    
    func getPosts(userId: Int, completion: @escaping ([Post]?, Error?) -> Void) {
        let parameters = ["userId": userId]
        performRequest(path: "posts", parameters: parameters, completion: completion)
    }
    
    func performRequest<T: Decodable>(path: String, parameters: [String: Any]?, completion: @escaping (T?, Error?) -> Void) {
        let urlString = "\(baseUrl)/\(path)"
        var components = URLComponents(string: urlString)
        components?.queryItems = parameters?.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        
        guard let url = components?.url else {
            completion(nil, NSError(domain: "Invalid URL", code: -1, userInfo: nil))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
            }
            
            if let data = data {
                do {
                    let decodeObject = try JSONDecoder().decode(T.self, from: data)
                    completion(decodeObject, nil)
                } catch {
                    completion(nil, error)
                }
            }
        }
        
        task.resume()
    }
    
}
