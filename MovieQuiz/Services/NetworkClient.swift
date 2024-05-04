//
//  NetworkClient.swift
//  MovieQuiz
//
//  Created by Roman Romanov on 01.05.2024.
//

import Foundation

struct NetworkClient {
    
    private enum NetworkError: Error {
        case codeError
    }
    
    func fetchAsync(url: URL) async throws -> Data {
        let request = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: request)

        // Проверяем, что нам пришёл успешный код ответа
        if let response = response as? HTTPURLResponse,
            response.statusCode < 200 || response.statusCode >= 300 {
            throw NetworkError.codeError
        }
        
        return data
    }
    
//    func fetch(url: URL, handler: @escaping (Result<Data, Error>) -> Void) {
//        let request = URLRequest(url: url)
//        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            // Проверяем, пришла ли ошибка
//            if let error = error {
//                handler(.failure(error))
//                return
//            }
//            
//            // Проверяем, что нам пришёл успешный код ответа
//            if let response = response as? HTTPURLResponse,
//               response.statusCode < 200 || response.statusCode >= 300 {
//                handler(.failure(NetworkError.codeError))
//                return
//            }
//            
//            // Возвращаем данные
//            guard let data = data else { return }
//            handler(.success(data))
//        }
//        
//        task.resume()
//    }
}
