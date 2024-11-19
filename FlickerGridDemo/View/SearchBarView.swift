//
//  SearchBarView.swift
//  FlickerGridDemo
//
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search flicker", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if !text.isEmpty {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }.background(.clear)
                ).background(.clear)
                .padding(.horizontal, 10)
        }.background(.clear)
    }
}
struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(text: .constant(""))
    }
}
