//
//  MostPopularMovies.swift
//  MovieQuiz
//
//  Created by Roman Romanov on 04.05.2024.
//

import Foundation

struct MostPopularMovies: Codable {
    let errorMessage: String
    let items: [MostPopularMovie]
}

struct MostPopularMovie: Codable {
    let title: String
    let rating: String
    let imageURL: URL
    
    var resizedImageURL: URL {
        // создаем строку из адреса
        let urlString = imageURL.absoluteString
        // обрезаем лишнюю часть и добавляем модификатор желаемого качества
        let imageUrlString = urlString.components(separatedBy: "._")[0] + "._V0_UX600_.jpg"
        
        // пытаемся создать новый адрес, если не получается возвращаем старый
        guard let newURL = URL(string: imageUrlString) else {
            return imageURL
        }
        
        return newURL
    }
    
    private enum CodingKeys: String, CodingKey {
        case title = "fullTitle"
        case rating = "imDbRating"
        case imageURL = "image"
    }
}
