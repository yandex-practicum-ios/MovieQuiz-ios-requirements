//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Roman Romanov on 16.04.2024.
//

import UIKit

final class AlertPresenter: AlertPresenterProtocol {
    weak var delegate: UIViewController?
        
    func callAlert(with model: AlertModel) {
        guard let delegate else { return }
        
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
        delegate.present(alert, animated: true, completion: nil)
    }
}
