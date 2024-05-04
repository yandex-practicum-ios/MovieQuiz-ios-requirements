//
//  QuestionFactoryProtocol.swift
//  MovieQuiz
//
//  Created by Roman Romanov on 14.04.2024.
//

import Foundation

protocol QuestionFactoryProtocol {
    func loadData() async
    func requestNextQuestion()
}
