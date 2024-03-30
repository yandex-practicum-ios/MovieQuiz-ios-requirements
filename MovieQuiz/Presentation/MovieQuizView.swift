//
//  MovieQuizView.swift
//  MovieQuiz
//
//  Created by Roman Romanov on 30.03.2024.
//

import UIKit

final class MovieQuizView: UIView {
    
    lazy private var headerStackView: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.spacing = 20
        
        return $0
    }(UIStackView())
    
    lazy private var bottomStackView: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 20
        
        return $0
    }(UIStackView())
    
    lazy var noButton: UIButton = {
        let button = UIButton()
        button.setTitle("Нет", for: .normal)
        
        let customFont = UIFont(name: "YS Display", size: 20.0)
        button.titleLabel?.font = UIFontMetrics.default.scaledFont(for: customFont!)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
        
        button.setTitleColor(.ypBlack, for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = .ypWhite

        return button
    }()
    
    lazy var yesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Да", for: .normal)
        
        let customFont = UIFont(name: "YS Display", size: 20.0)
        button.titleLabel?.font = UIFontMetrics.default.scaledFont(for: customFont!)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
        
        button.setTitleColor(.ypBlack, for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = .ypWhite

        return button
    }()
    
    lazy var questionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Вопрос"
        let customFont = UIFont(name: "YS Display", size: 20.0)
        label.font = UIFontMetrics.default.scaledFont(for: customFont!)
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
        label.textColor = .ypWhite
        
        return label
    }()
    
    lazy var indexLabel: UILabel = {
        let label = UILabel()
        label.text = "1/10"
        let customFont = UIFont(name: "YS Display", size: 20.0)
        label.font = UIFontMetrics.default.scaledFont(for: customFont!)
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
        label.textColor = .ypWhite
        
        return label
    }()
    
    lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Рейтинг этого фильма больше чем 6?"
        let customFont = UIFont(name: "YS Display", size: 20.0)
        label.font = UIFontMetrics.default.scaledFont(for: customFont!)
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
        label.textColor = .ypWhite
        
        return label
    }()
    
    lazy var previewImage: UIImageView = {
        let logoImage = UIImage(named: "The Godfather")
        let imageView = UIImageView(image: logoImage!)
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .ypBlack
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        // header
        [
            questionTitleLabel,
            indexLabel,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            headerStackView.addArrangedSubview($0)
        }
        // bottom
        [
            noButton,
            yesButton,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            bottomStackView.addArrangedSubview($0)
        }
        //
        [
            // TODO: - remove this after review
//            noButton,
//            yesButton,
//            questionTitleLabel,
            headerStackView,
            previewImage,
//            questionLabel,
            bottomStackView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
//            questionTitleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            questionTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            headerStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            headerStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            headerStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            previewImage.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 20),
            previewImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            previewImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            // TODO: - need to add questionLabel into stackView
//            questionLabel.topAnchor.constraint(equalTo: previewImage.bottomAnchor, constant: 20),
//            questionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            questionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            bottomStackView.topAnchor.constraint(equalTo: previewImage.bottomAnchor, constant: 20),
            bottomStackView.heightAnchor.constraint(equalToConstant: 60),
            bottomStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            bottomStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            bottomStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            // TODO: - remove this after review
//            noButton.heightAnchor.constraint(equalToConstant: 60),
//            noButton.widthAnchor.constraint(equalTo: yesButton.widthAnchor),
//            noButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            noButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
//            
//            yesButton.leadingAnchor.constraint(equalTo: noButton.trailingAnchor, constant: 20),
//            yesButton.heightAnchor.constraint(equalTo: noButton.heightAnchor),
//            yesButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
//            yesButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}
