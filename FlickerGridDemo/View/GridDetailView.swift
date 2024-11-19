//
//  GridDetailView.swift
//  FlickerGridDemo
//
//  Created by Mital Khandhar on 26/09/24.
//

import SwiftUI

struct GridDetailView: View {
    let item: FlickerModel
    
    var body: some View {
        ZStack{
            Color(red: 52/255, green: 152/255, blue: 219/255, opacity: 0.5).ignoresSafeArea()
            VStack {
                ImageView(url: item.media.m).cornerRadius(20)
                    .frame(maxWidth: .infinity, maxHeight: 230)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Title: \(item.title)")
                        .font(.title2)
                        .padding(.top, 10)
                    
                    Text("Author Name: \(item.author)")
                        .font(.subheadline)
                    
                    Text("Description:")
                        .font(.subheadline)
                    let attributedString = attributedString(from: item.description)
                    AttributedLabel(attributedText: attributedString).font(.subheadline)
                    
                    if let publishedDate = dateFormatter.date(from: item.published) {
                        Text("Publish on: \(formattedDate(from: publishedDate))")
                            .font(.subheadline)
                    } else {
                        Text("Publish on: \(item.published)")
                            .font(.subheadline)
                    }
                }
                .padding()
            }.padding(.top,5)
        }
    }
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd'T'HH:mm:ssZ"
        return formatter
    }()
    private func formattedDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter.string(from: date)
    }
    private func attributedString(from html: String) -> NSAttributedString {
            guard let data = html.data(using: .utf8) else { return NSAttributedString() }
            do {
                let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ]
                return try NSAttributedString(data: data, options: options, documentAttributes: nil)
            } catch {
                print("Error string: \(error)")
                return NSAttributedString()
            }
        }
}
struct AttributedLabel: UIViewRepresentable {
    var attributedText: NSAttributedString
    
    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.attributedText = attributedText
        return label
    }
    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.attributedText = attributedText
    }
}
