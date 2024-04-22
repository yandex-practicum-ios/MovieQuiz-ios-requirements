//
//  StatisticServiceImplementation.swift
//  MovieQuiz
//
//  Created by Roman Romanov on 21.04.2024.
//

import Foundation

final class StatisticServiceImplementation: StatisticService {
    
    private let userDefaults = UserDefaults.standard
    private enum Keys: String {
        case correct, total, bestGame, gamesCount
    }
    
    var totalAccuracy: Double {
        get {
            let correctAnswers = userDefaults.integer(forKey: Keys.correct.rawValue)
            let totalAnswers = userDefaults.integer(forKey: Keys.total.rawValue)
            return Double(correctAnswers * 100 / totalAnswers)
        }
    }
    
    var gamesCount: Int {
        get {
            userDefaults.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    var bestGame: GameRecord {
        get {
            guard let data = userDefaults.data(forKey: Keys.bestGame.rawValue),
                  let record = try? JSONDecoder().decode(GameRecord.self, from: data) else {
                return .init(correct: 0, total: 0, date: Date())
            }
            
            return record
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Невозможно сохранить результат bestGame")
                return
            }
            
            userDefaults.set(data, forKey: Keys.bestGame.rawValue)
        }
    }
    
    func store(correct count: Int, total amount: Int) {
        let newBestGame = GameRecord(correct: count, total: amount, date: Date())
        gamesCount += 1
        
        if newBestGame.isBetterThan(bestGame) {
            print("save new record")
            bestGame = newBestGame
        }
        
        var totalCorrectAnswers = userDefaults.integer(forKey: Keys.correct.rawValue)
        totalCorrectAnswers += count
        userDefaults.set(totalCorrectAnswers, forKey: Keys.correct.rawValue)
        
        var totalAnswers = userDefaults.integer(forKey: Keys.total.rawValue)
        totalAnswers += amount
        userDefaults.set(totalAnswers, forKey: Keys.total.rawValue)
    }
}
