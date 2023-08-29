//
//  PostController.swift
//  TestIOS
//
//  Created by Santiago Restrepo Marin on 28/08/23.
//

import Foundation
import SQLite

class PostController {
    static let shared = PostController()
    private let db: Connection?
    
    private init() {
        db = LocalPersistenceService.shared.getConnection()
        self.createTable()
    }
    
    func createTable() {
        do {
            try db?.run(Post.table.create(ifNotExists: true) { table in
                table.column(Post.Columns.id, primaryKey: true)
                table.column(Post.Columns.userId)
                table.column(Post.Columns.title)
                table.column(Post.Columns.body)
            })
        } catch {
            print("Error creating post table: \(error)")
        }
    }
    
    func getAll(userId: Int, hasSyncedFromApi: Bool, completion: @escaping ([Post]) -> Void) -> [Post] {
        var posts: [Post] = []
        if !posts.isEmpty {
            completion(posts)
        }
        
        if posts.isEmpty && !hasSyncedFromApi {
            fetchPostsFromAPI(userId: userId) {
                completion(self.getPosts(userId: userId))
            }
        }
        
        return posts
    }
    
    private func getPosts(userId: Int) -> [Post] {
        var posts: [Post] = []
        do {
            let query = Post.table.filter(Post.Columns.userId == userId)
            
            posts = try db?.prepare(query).map { row in
                return Post.fromRow(row: row)
            } ?? []
        } catch {
            print("Error fetching posts from database: \(error)")
        }
        return posts
    }
    
    private func fetchPostsFromAPI(userId: Int, completion: @escaping () -> Void) {
        NetworkService.shared.getPosts(userId: userId) { posts, error in
            if let error = error {
                print("Error fetching posts from API: \(error)")
                completion()
                return
            }
            
            if let posts = posts {
                do {
                    try self.db?.transaction {
                        for post in posts {
                            let setters = Post.encode(post)
                            try self.db?.run(Post.table.insert(or: .replace, setters))
                        }
                    }
                    DispatchQueue.main.async {
                        completion()
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
