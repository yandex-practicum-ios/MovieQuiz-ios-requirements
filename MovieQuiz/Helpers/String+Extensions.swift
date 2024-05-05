//
//  String+Extensions.swift
//  MovieQuiz
//
//  Created by Roman Romanov on 05.05.2024.
//

import Foundation

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}
