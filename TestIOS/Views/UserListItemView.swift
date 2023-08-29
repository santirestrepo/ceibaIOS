//
//  UserListItemView.swift
//  TestIOS
//
//  Created by Santiago Restrepo Marin on 28/08/23.
//

import SwiftUI

struct UserListItemView: View {
    var user: User
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(user.name)
                .font(.headline)
            Text(user.email)
                .font(.subheadline)
            Text(user.phone)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
}

struct UserListItemView_Previews: PreviewProvider {
    static var previews: some View {
        UserListItemView(user: User.example)
    }
}
