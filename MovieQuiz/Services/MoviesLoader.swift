//
//  MoviesLoader.swift
//  MovieQuiz
//
//  Created by Roman Romanov on 04.05.2024.
//

import Foundation

protocol MoviesLoadingProtocol {
    func loadMovies(handler: @escaping (Result<MostPopularMovies, Error>) -> Void) async
}

struct MoviesLoader: MoviesLoadingProtocol {
    // MARK: - NetworkClient
    private let networkClient = NetworkClient()
    
    // MARK: - URL
    private var mostPopularMoviesUrl: URL {
        // Если мы не смогли преобразовать строку в URL, то приложение упадёт с ошибкой
        // TODO: move to constant
        guard let url = URL(string: "https://tv-api.com/en/API/Top250Movies/k_zcuw1ytf") else {
            preconditionFailure("Unable to construct mostPopularMoviesUrl")
        }
        return url
    }
    
    // MARK: - loadMovies with closure
//    func loadMovies(handler: @escaping (Result<MostPopularMovies, Error>) -> Void) {
//        networkClient.fetch(url: mostPopularMoviesUrl) { result in
//            switch result {
//            case .success(let data):
//                do {
//                    let mostPopularMovies = try JSONDecoder().decode(MostPopularMovies.self, from: data)
//                    handler(.success(mostPopularMovies))
//                } catch {
//                    handler(.failure(error))
//                }
//            case .failure(let error):
//                handler(.failure(error))
//            }
//        }
//    }
    
    // MARK: - loadMovies with async/await
    func loadMovies(handler: @escaping (Result<MostPopularMovies, Error>) -> Void) async {
        Task {
            do {
                let data = try await networkClient.fetchAsync(url: mostPopularMoviesUrl)
                let mostPopularMovies = try JSONDecoder().decode(MostPopularMovies.self, from: data)

                if !mostPopularMovies.errorMessage.isEmpty {
                    print("Error in loaded data: \(mostPopularMovies.errorMessage)")
                    handler(.failure(mostPopularMovies.errorMessage))
                    return
                }
                
                handler(.success(mostPopularMovies))
            } catch {
                print("Error during data loading: \(error)")
                handler(.failure(error))
            }
        }
    }
}

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}
