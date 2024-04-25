//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Roman Romanov on 16.04.2024.
//

import Foundation

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let completion: (() -> Void)?
}
