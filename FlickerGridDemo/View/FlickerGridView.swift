//
//  FlickerGridView.swift
//  FlickerGridDemo
//
//

import SwiftUI


struct FlickerGridView: View {
    @StateObject private var flickerViewModel = FlickerGridViewModel()
    @State private var searchText: String = ""
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(text: $flickerViewModel.searchText)
                    .padding(.horizontal).background(.clear)
                 
                GeometryReader { geometry in
                    ScrollView {
                        let columns = [GridItem(.adaptive(minimum: geometry.size.width / 2 - 12))]
                        
                        LazyVGrid(columns: columns, spacing: 5) {
                            ForEach(flickerViewModel.filtereItem) { item in
                                NavigationLink(destination: GridDetailView(item: item)) {
                                    VStack {
                                        ImageView(url: item.media.m).cornerRadius(10)
                                            .frame(width: geometry.size.width / 2 - 12, height: geometry.size.width / 2 - 12)
                                        Text(item.title).lineLimit(1).foregroundColor(.white).font(.title3)
                                    }
                                    .frame(width: geometry.size.width / 2 - 12)
                                }
                            }
                        }
                        .padding(.horizontal, 5)
                    }
                }
            }.background(Color(red: 52/255, green: 152/255, blue: 219/255, opacity: 0.5))
            
            .navigationBarTitle("Flicker Grid")
        }
    }
}

#Preview {
    FlickerGridView()
}
