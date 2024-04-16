//
//  AlertPresenterDelegate.swift
//  MovieQuiz
//
//  Created by Roman Romanov on 16.04.2024.
//

import UIKit

protocol AlertPresenterDelegate: AnyObject {
    func showAlert(with alert: UIAlertController)
}
