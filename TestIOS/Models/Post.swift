//
//  Post.swift
//  TestIOS
//
//  Created by Santiago Restrepo Marin on 28/08/23.
//

import Foundation
import SQLite

struct Post: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

extension Post {
    static var tableName: String {
        return "posts"
    }
    
    static var table: Table {
        return Table(tableName)
    }
    
    static func fromRow(row: Row) -> Post {
        return Post(
            userId: row[Columns.userId],
            id: row[Columns.id],
            title: row[Columns.title],
            body: row[Columns.body]
        )
    }
    
    static func encode(_ post: Post) -> [Setter] {
        return [
            Columns.userId <- post.userId,
            Columns.id <- post.id,
            Columns.title <- post.title,
            Columns.body <- post.body
        ]
    }
    
    static func decode(row: Row) -> Post {
        return Post(
            userId: row[Columns.userId],
            id: row[Columns.id],
            title: row[Columns.title],
            body: row[Columns.body]
        )
    }

    struct Columns {
        static let id = Expression<Int>("id")
        static let userId = Expression<Int>("user_id")
        static let title = Expression<String>("title")
        static let body = Expression<String>("body")
    }
}
