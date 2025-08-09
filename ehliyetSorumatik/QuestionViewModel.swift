import Foundation

class QuestionViewModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var currentIndex: Int = 0 {
        didSet {
            saveCurrentIndex()
        }
    }
    @Published var selectedAnswer: String? = nil
    @Published var answerSubmitted: Bool = false
    
    private let currentIndexKey = "currentQuestionIndex"  // UserDefaults anahtarı
    
    init() {
        loadQuestions()
        loadCurrentIndex()
    }
    
    func loadQuestions() {
        guard let url = Bundle.main.url(forResource: "questions", withExtension: "json") else {
            print("questions.json bulunamadı")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            questions = try JSONDecoder().decode([Question].self, from: data)
        } catch {
            print("JSON okuma hatası: \(error)")
        }
    }
    
    func submitAnswer(_ answer: String) {
        guard !answerSubmitted else { return }
        selectedAnswer = answer
        answerSubmitted = true
    }
    
    func nextQuestion() {
        selectedAnswer = nil
        answerSubmitted = false
        
        if currentIndex + 1 < questions.count {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
    }
    
    var currentQuestion: Question? {
        if questions.isEmpty { return nil }
        return questions[currentIndex]
    }
    
    // UserDefaults’a kaydet
    private func saveCurrentIndex() {
        UserDefaults.standard.set(currentIndex, forKey: currentIndexKey)
    }
    
    // UserDefaults’tan yükle
    private func loadCurrentIndex() {
        let savedIndex = UserDefaults.standard.integer(forKey: currentIndexKey)
        if savedIndex < questions.count {
            currentIndex = savedIndex
        } else {
            currentIndex = 0
        }
    }
}



