//
//  GameRecord.swift
//  MovieQuiz
//
//  Created by Roman Romanov on 21.04.2024.
//

import Foundation

struct GameRecord: Codable {
    let correct: Int
    let total: Int
    let date: Date
    
    func isBetterThan(_ newResult: GameRecord) -> Bool {
        correct > newResult.correct
    }
}
