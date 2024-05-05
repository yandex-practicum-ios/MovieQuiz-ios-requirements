//
//  MovieQuizView.swift
//  MovieQuiz
//
//  Created by Roman Romanov on 30.03.2024.
//

import UIKit

final class MovieQuizView: UIView {
    
    // MARK: PROPERTIES
    lazy private var headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    lazy private var footerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        return stackView
    }()
    
    lazy private var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = 20
        
        return stackView
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        
        return activityIndicator
    }()
    
    lazy var noButton: UIButton = {
        let button = UIButton()
        button.setTitle("Нет", for: .normal)
        
        button.titleLabel?.font = UIFontMetrics.default.scaledFont(for: AppFontSettings.customFont!)
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
        
        button.titleLabel?.font = UIFontMetrics.default.scaledFont(for: AppFontSettings.customFont!)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
        
        button.setTitleColor(.ypBlack, for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = .ypWhite
        
        return button
    }()
    
    lazy private var questionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Вопрос"
        
        label.font = UIFontMetrics.default.scaledFont(for: AppFontSettings.customFont!)
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
        label.textColor = .ypWhite
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return label
    }()
    
    lazy var indexLabel: UILabel = {
        let label = UILabel()
        label.text = "0/0"
        
        label.font = UIFontMetrics.default.scaledFont(for: AppFontSettings.customFont!)
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
        label.textColor = .ypWhite
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return label
    }()
    
    lazy var questionLabel: UILabel = {
        let label = EdgeInsetLabel()
        label.textInsets = UIEdgeInsets(top: 0, left: 42, bottom: 0, right: 42)
        label.text = "Рейтинг этого фильма больше чем X?"
        
        label.font = UIFontMetrics.default.scaledFont(for: AppFontSettings.customFont!)
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.systemFont(ofSize: 23.0, weight: .bold)
        label.textColor = .ypWhite
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var previewImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .ypWhite
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        
        return imageView
    }()
    
    // MARK: INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .ypBlack
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LAYOUT
    private func setupLayout() {
        // header
        [
            questionTitleLabel,
            indexLabel,
        ].forEach {
            headerStackView.addArrangedSubview($0)
        }
        // footer
        [
            noButton,
            yesButton,
        ].forEach {
            footerStackView.addArrangedSubview($0)
        }
        // body
        [
            headerStackView,
            previewImage,
            questionLabel,
            footerStackView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            mainStackView.addArrangedSubview($0)
        }
        // main elements
        [
            mainStackView,
            activityIndicator,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            
            mainStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            previewImage.heightAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.heightAnchor, multiplier: 2.0/3.0),
            questionLabel.heightAnchor.constraint(equalToConstant: 78),
            footerStackView.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
}
