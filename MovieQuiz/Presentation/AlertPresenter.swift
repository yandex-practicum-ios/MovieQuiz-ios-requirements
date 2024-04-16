//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Roman Romanov on 16.04.2024.
//

import UIKit

final class AlertPresenter: AlertPresenterProtocol {
    weak var delegate: AlertPresenterDelegate?
        
    func callAlert(with model: AlertModel) {
        let alert = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: .alert)
        
        let action = UIAlertAction (title: model.buttonText, style: .default) { _ in
            if let completion = model.completion {
                completion()
            }
        }
        
        alert.addAction(action)
        delegate?.showAlert(with: alert)
    }
}
