//
//  UserDetailView.swift
//  TestIOS
//
//  Created by Santiago Restrepo Marin on 28/08/23.
//

import SwiftUI

struct UserDetailView: View {
    var user: User
    @StateObject private var postViewModel = PostViewModel()
    @State private var posts: [Post] = []
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Name: \(user.name)")
                    .font(.headline)
                Text("Username: \(user.username)")
                    .font(.subheadline)
                Text("Email: \(user.email)")
                    .font(.subheadline)
                Text("Phone: \(user.phone)")
                    .font(.subheadline)
                Text("Website: \(user.website)")
                    .font(.subheadline)
            }
            Divider()
            VStack(alignment: .leading) {
                Text("Address")
                    .font(.headline)
                
                Text("Street: \(user.addressStreet)")
                    .font(.subheadline)
                Text("Suite: \(user.addressSuite)")
                    .font(.subheadline)
                Text("City: \(user.addressCity)")
                    .font(.subheadline)
                Text("ZipCode: \(user.addressZipcode)")
                    .font(.subheadline)
                Text("Geo: \(user.addressGeoLat), \(user.addressGeoLng)")
                    .font(.subheadline)
            }
            Divider()
            VStack(alignment: .leading) {
                Text("Company")
                    .font(.headline)
                
                Text("Name: \(user.companyName)")
                    .font(.subheadline)
                Text("Catch Phrase: \(user.companyCatchPhrase)")
                    .font(.subheadline)
                Text("Bs: \(user.companyBs)")
                    .font(.subheadline)
            }
            Divider()
            Button("Ver publicaciones") {
                postViewModel.getPosts(userId: user.id) { fetchedPosts, _ in
                    posts = fetchedPosts ?? []
                }
            }
            
            List(posts, id: \.id) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 8)
            }
        }
        .padding()
        .navigationTitle("User Detail")
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: User.example)
    }
}
