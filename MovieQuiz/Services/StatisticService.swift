//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Roman Romanov on 21.04.2024.
//

import Foundation

protocol StatisticService {
    var totalAccuracy: Double { get }
    var gamesCount: Int { get }
    var bestGame: GameRecord { get }
    
    func store(correct count: Int, total amount: Int)
}
