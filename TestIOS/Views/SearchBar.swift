//
//  SearchBar.swift
//  TestIOS
//
//  Created by Santiago Restrepo Marin on 28/08/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
        
        var body: some View {
            HStack {
                TextField("Search", text: $text)
                    .padding(.horizontal, 25)
                    .padding(.vertical, 8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                if !text.isEmpty {
                    Button(action: {
                        text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 8)
                    .transition(.move(edge: .trailing))
                }
            }
        }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
