//
//  File.swift
//  FlickerGridDemo
//
//

import Foundation

import Foundation
class FlickerAPI {
    
    var baseULR = "https://api.flickr.com/services/feeds/photos_public.gne"
    
    func fetchFlickerList(text: String) async throws -> FlickrListResponse? {
        
            let baseURL = URL(string:baseULR )!
            var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
            components?.queryItems = [ URLQueryItem(name: "nojsoncallback", value: "1"),
                URLQueryItem(name: "format", value: "json"),
                URLQueryItem(name: "tags", value: text)]
            
            guard let url = components?.url else {
                throw URLError(.badURL)
            }
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            let jsonString = String(data: data, encoding: .utf8)?
                .replacingOccurrences(of: "jsonFlickrFeed(", with: "")
                .replacingOccurrences(of: ")", with: "")
            
            guard let cleanedData = jsonString?.data(using: .utf8) else {
                throw URLError(.cannotDecodeContentData)
            }
            let list = try JSONDecoder().decode(FlickrListResponse.self, from: cleanedData)
            return list
        }
}
