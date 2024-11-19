//
//  FlickerModel.swift
//  FlickerGridDemo
//
//

import Foundation

struct FlickerModel: Decodable, Identifiable {
    var id = UUID()
    let media: Media
    let date_taken: String
    let description: String
    let title: String
    let link: URL
    let published: String
    let author: String
    let author_id: String
    let tags: String
    enum CodingKeys: String, CodingKey {
        case title
        case link
        case media
        case date_taken
        case description
        case published
        case author
        case author_id
        case tags
    }
}
struct Media: Decodable {
    let m: URL
}

struct FlickrListResponse: Decodable {
    let title: String
    let link: URL
    let description: String
    let modified: String
    let generator: URL
    let items: [FlickerModel]
}
