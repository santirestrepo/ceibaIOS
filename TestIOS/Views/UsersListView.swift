//
//  UsersListView.swift
//  TestIOS
//
//  Created by Santiago Restrepo Marin on 28/08/23.
//

import SwiftUI

struct UsersListView: View {
    @StateObject private var viewModel = UserViewModel()
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
                .padding(.horizontal)
            
            List(viewModel.filteredUsers(for: searchText)) { user in
                NavigationLink(destination: UserDetailView(user: user)) {
                    UserListItemView(user: user)
                }
            }
            .listStyle(PlainListStyle())
            
            if viewModel.users.isEmpty && !searchText.isEmpty {
                Text("List is empty")
                    .foregroundColor(.gray)
                    .padding(.top, 10)
            }
        }
        .onAppear {
            viewModel.getUsers()
        }
    }
}

struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView()
    }
}
