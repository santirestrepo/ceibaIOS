//
//  ContentView.swift
//  TestIOS
//
//  Created by Santiago Restrepo Marin on 27/08/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            UsersListView()
                .navigationBarTitle("Users")
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
