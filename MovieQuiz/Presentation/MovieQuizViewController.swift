import UIKit

final class MovieQuizViewController: UIViewController {
    // MARK: PROPERTIES
    override internal var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private let movieQuizView = MovieQuizView()
    
    private var currentQuestionIndex = 0
    private var correctAnswers = 0
    private let questionsAmount: Int = 10
    private var questionFactory: QuestionFactoryProtocol?
    private var currentQuestion: QuizQuestion?
    private var alertPresenter: AlertPresenterProtocol?
    
    private lazy var statisticService: StatisticService = StatisticServiceImplementation()
    private lazy var moviesLoader: MoviesLoadingProtocol = MoviesLoader()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view = movieQuizView
        setupButton()
        
        let alertPresenter = AlertPresenter()
        alertPresenter.delegate = self
        self.alertPresenter = alertPresenter
        
        let questionFactory = QuestionFactory(moviesLoader: moviesLoader, delegate: self)
        self.questionFactory = questionFactory
        
        showLoadingIndicator()
        questionFactory.loadData()
    }
    
    // MARK: - SETUP
    
    private func setupButton() {
        movieQuizView.noButton.addTarget(self, action: #selector(tapNoAction), for: .touchUpInside)
        movieQuizView.yesButton.addTarget(self, action: #selector(tapYesAction), for: .touchUpInside)
    }
    
    @objc private func tapYesAction() {
        showAnswerResult(isCorrect: true)
    }
    
    @objc private func tapNoAction() {
        showAnswerResult(isCorrect: false)
    }
}

// MARK: - DELEGATES

extension MovieQuizViewController: QuestionFactoryDelegate {
    func didReceiveNextQuestion(question: QuizQuestion?) {
        guard let question else { return }
        
        currentQuestion = question
        let viewModel = convert(model: question)
        
        DispatchQueue.main.async { [weak self] in
            self?.show(quiz: viewModel)
        }
    }
    
    func didLoadDataFromServer() {
        hideLoadingIndicator()
        questionFactory?.requestNextQuestion()
    }
    
    func didFailToLoadData(with error: any Error) {
        showNetworkError(message: error.localizedDescription)
    }
}

// MARK: - FUNCTIONS

extension MovieQuizViewController {
    private func showLoadingIndicator() {
        movieQuizView.activityIndicator.isHidden = false
        movieQuizView.activityIndicator.startAnimating()
    }
    
    private func hideLoadingIndicator() {
        self.movieQuizView.activityIndicator.isHidden = true
        self.movieQuizView.activityIndicator.stopAnimating()
    }
    
    private func showNetworkError(message: String) {
        hideLoadingIndicator()
        
        let model = AlertModel(
            title: "Ошибка",
            message: message,
            buttonText: "Попробовать ещё раз") { [weak self] in
                guard let self else { return }
                
                self.correctAnswers = 0
                self.currentQuestionIndex = 0
                // load data one more time
                self.showLoadingIndicator()
                Task {
                    await self.questionFactory?.loadData()
                }
            }
        
        alertPresenter?.callAlert(with: model)
    }
    
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        QuizStepViewModel(
            image: UIImage(data: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
    }
    
    private func show(quiz step: QuizStepViewModel) {
        movieQuizView.previewImage.image = step.image
        movieQuizView.questionLabel.text = step.question
        movieQuizView.indexLabel.text = step.questionNumber
    }
    
    private func showAnswerResult(isCorrect: Bool) {
        guard let currentQuestion else { return }
        
        let isCorrectAnswer = isCorrect == currentQuestion.correctAnswer
        
        if isCorrectAnswer {
            correctAnswers += 1
        }
        
        movieQuizView.yesButton.isEnabled = false
        movieQuizView.noButton.isEnabled = false
        // даём разрешение на рисование рамки
        movieQuizView.previewImage.layer.masksToBounds = true
        movieQuizView.previewImage.layer.borderWidth = 8
        // делаем рамку
        movieQuizView.previewImage.layer.borderColor = isCorrectAnswer
            ? UIColor.ypGreen.cgColor
            : UIColor.ypRed.cgColor
        movieQuizView.previewImage.layer.cornerRadius = 20
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self else { return }
            
            self.movieQuizView.previewImage.layer.borderWidth = 0
            self.showNextQuestionOrResults()
            self.movieQuizView.yesButton.isEnabled = true
            self.movieQuizView.noButton.isEnabled = true
        }
    }
    
    private func showNextQuestionOrResults() {
        guard currentQuestionIndex == questionsAmount - 1 else {
            currentQuestionIndex += 1
            questionFactory?.requestNextQuestion()
            
            return
        }
        
        statisticService.store(correct: correctAnswers, total: questionsAmount)
        
        let bestGame = statisticService.bestGame
        let message = """
            Ваш результат: \(correctAnswers)/\(questionsAmount)
            Количество сыгранных квизов: \(statisticService.gamesCount)
            Рекорд \(bestGame.correct)/\(bestGame.total) \(bestGame.date.dateTimeString)
            Срендяя точность \(String(format: "%.2f", statisticService.totalAccuracy))%
        """
        
        let viewModel = QuizResultsViewModel(
            title: "Этот раунд окончен!",
            text: message,
            buttonText: "Сыграть ещё раз")
        
        showQuizResults(quiz: viewModel)
    }
    
    private func showQuizResults(quiz result: QuizResultsViewModel) {
        let model = AlertModel(
            title: result.title,
            message: result.text, 
            buttonText: result.buttonText) { [weak self] in
                guard let self else { return }
                
                self.correctAnswers = 0
                self.currentQuestionIndex = 0
                self.questionFactory?.requestNextQuestion()
            }
        
        alertPresenter?.callAlert(with: model)
    }
    
}
