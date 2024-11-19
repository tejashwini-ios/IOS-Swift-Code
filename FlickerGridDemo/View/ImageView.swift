//
//  ImageView.swift
//  FlickerGridDemo
//
//

import SwiftUI

struct ImageView: View {
    
    @State private var image: Image? = nil
    let url: URL
    var body: some View {
        if let image = image {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
        } else {
            ProgressView()
                .frame(width: 90, height: 90)
                .onAppear {
                    loadImageURL()
                }
        }
    }
    private func loadImageURL() {
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let uiImage = UIImage(data: data) {
                    image = Image(uiImage: uiImage)
                }
            } catch {
                print("Failed to loading images: \(error)")
            }
        }
    }
}
