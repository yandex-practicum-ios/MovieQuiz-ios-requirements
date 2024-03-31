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
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        
        return $0
    }(UIStackView())
    
    lazy private var footerStackView: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 20
        
        return $0
    }(UIStackView())
    
    lazy private var mainStackView: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .equalCentering
        $0.spacing = 20
        $0.translatesAutoresizingMaskIntoConstraints = false
        
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
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return label
    }()
    
    lazy var indexLabel: UILabel = {
        let label = UILabel()
        label.text = "0/0"
        let customFont = UIFont(name: "YS Display", size: 20.0)
        label.font = UIFontMetrics.default.scaledFont(for: customFont!)
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
        label.textColor = .ypWhite
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return label
    }()
    
    lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Рейтинг этого фильма больше чем X?"
        let customFont = UIFont(name: "YS Display", size: 23.0)
        label.font = UIFontMetrics.default.scaledFont(for: customFont!)
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
        
        addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
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
