//
//  PostViewModel.swift
//  TestIOS
//
//  Created by Santiago Restrepo Marin on 28/08/23.
//

import Foundation

class PostViewModel: ObservableObject {
    private let postController = PostController.shared
    
    func getPosts(userId: Int, completion: @escaping ([Post]?, Error?) -> Void) {
        postController.getAll(userId: userId, hasSyncedFromApi: false) { _posts in
            
            completion(_posts, nil)
        }
        
    }
}
