//
//  UserViewModel.swift
//  TestIOS
//
//  Created by Santiago Restrepo Marin on 28/08/23.
//

import Foundation

class UserViewModel: ObservableObject {
    private let userController = UserController.shared
    
    @Published var users: [User] = []
    
    func getUsers() {
        userController.getAll(hasSyncedFromApi: false) { _users in
            self.users = _users
        }
    }
    
    func filteredUsers(for searchText: String) -> [User] {
        if searchText.isEmpty {
            return users
        } else {
            return users.filter { user in
                user.name.localizedCaseInsensitiveContains(searchText) ||
                user.email.localizedCaseInsensitiveContains(searchText) ||
                user.phone.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}
