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
    private var questionFactory: QuestionFactory = QuestionFactory()
    private var currentQuestion: QuizQuestion?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view = movieQuizView
        
        setupButton()
        
        guard let firstQuestion = questionFactory.requestNextQuestion() else {
            return
        }
        currentQuestion = firstQuestion
        let viewModel = convert(model: firstQuestion)
        show(quiz: viewModel)
    }
    
    // MARK: SETUP
    
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

// MARK: FUNCTIONS

extension MovieQuizViewController {
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        QuizStepViewModel(
            image: UIImage(named: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
    }
    
    private func show(quiz step: QuizStepViewModel) {
        movieQuizView.previewImage.image = step.image
        movieQuizView.questionLabel.text = step.question
        movieQuizView.indexLabel.text = step.questionNumber
    }
    
    private func showAnswerResult(isCorrect: Bool) {
        guard let currentQuestion = currentQuestion else {
            return
        }
        
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
            guard let self = self else { return }
            
            self.movieQuizView.previewImage.layer.borderWidth = 0
            self.showNextQuestionOrResults()
            self.movieQuizView.yesButton.isEnabled = true
            self.movieQuizView.noButton.isEnabled = true
        }
    }
    
    private func showNextQuestionOrResults() {
        guard currentQuestionIndex == questionsAmount - 1 else {
            currentQuestionIndex += 1
            
            guard let nextQuestion = questionFactory.requestNextQuestion() else {
                return
            }
            currentQuestion = nextQuestion
            let viewModel = convert(model: nextQuestion)
            show(quiz: viewModel)
            
            return
        }
        
        let viewModel = QuizResultsViewModel(
            title: "Этот раунд окончен!",
            text: "Ваш результат: \(correctAnswers)/\(questionsAmount)",
            buttonText: "Сыграть ещё раз")
        
        showQuizResults(quiz: viewModel)
    }
    
    private func showQuizResults(quiz result: QuizResultsViewModel) {
        let alert = UIAlertController(
            title: result.title,
            message: result.text,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: result.buttonText, style: .default) { [weak self] _ in
            guard let self = self else { return }
            
            self.correctAnswers = 0
            self.currentQuestionIndex = 0
            
            guard let firstQuestion = questionFactory.requestNextQuestion() else {
                return
            }
            currentQuestion = firstQuestion
            let viewModel = convert(model: firstQuestion)
            self.show(quiz: viewModel)
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
