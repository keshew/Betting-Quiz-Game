import Foundation
import Combine

class QuizManager: ObservableObject {
    @Published private(set) var questions: [Question] = []
    @Published var currentQuestionIndex = 0
    @Published var score = 0
    @Published var timeRemaining = 15
    @Published var quizEnded = false

    private var timer: Timer?
    
    init() {
        loadQuestions()
        startTimer()
    }
    
    func loadQuestions() {
        let allQuestions = [
            Question(
                text: "Which team won the UEFA Champions League in 2023?",
                options: ["Manchester City", "Real Madrid", "Bayern Munich", "Liverpool"],
                correctAnswerIndex: 1
            ),
            Question(
                text: "What was the final score of the NBA Finals 2024 Game 7?",
                options: ["101-99", "112-108", "98-95", "105-103"],
                correctAnswerIndex: 3
            ),
            Question(
                text: "Who scored the winning goal in the 2022 FIFA World Cup final?",
                options: ["Kylian Mbappé", "Lionel Messi", "Luka Modrić", "Gianluigi Donnarumma"],
                correctAnswerIndex: 1
            ),
            Question(
                text: "Which NFL team has won the most Super Bowl titles?",
                options: ["New England Patriots", "Pittsburgh Steelers", "Dallas Cowboys", "San Francisco 49ers"],
                correctAnswerIndex: 0
            ),
            Question(
                text: "Who holds the record for most Grand Slam tennis titles?",
                options: ["Roger Federer", "Rafael Nadal", "Novak Djokovic", "Pete Sampras"],
                correctAnswerIndex: 2
            ),
            Question(
                text: "Which NHL team won the Stanley Cup in 2021?",
                options: ["Tampa Bay Lightning", "Colorado Avalanche", "Chicago Blackhawks", "Boston Bruins"],
                correctAnswerIndex: 0
            ),
            Question(
                text: "What is the standard length of a Formula 1 Grand Prix race in kilometers?",
                options: ["305 km", "250 km", "350 km", "400 km"],
                correctAnswerIndex: 0
            ),
            Question(
                text: "Which basketball player is known as 'His Airness'?",
                options: ["LeBron James", "Kobe Bryant", "Michael Jordan", "Kevin Durant"],
                correctAnswerIndex: 2
            ),
            Question(
                text: "Which country hosted the 2016 Summer Olympics?",
                options: ["China", "Brazil", "Russia", "United Kingdom"],
                correctAnswerIndex: 1
            ),
            Question(
                text: "What year did Roger Federer win his first Wimbledon title?",
                options: ["2001", "2003", "2005", "2007"],
                correctAnswerIndex: 1
            ),
            Question(
                text: "Which soccer club is nicknamed 'The Red Devils'?",
                options: ["Liverpool", "Manchester United", "Arsenal", "Chelsea"],
                correctAnswerIndex: 1
            ),
            Question(
                text: "Who won the NBA MVP award in 2022?",
                options: ["Nikola Jokić", "Giannis Antetokounmpo", "Luka Dončić", "Joel Embiid"],
                correctAnswerIndex: 0
            ),
            Question(
                text: "Which country won the most gold medals at the 2020 Tokyo Olympics?",
                options: ["USA", "China", "Russia", "Japan"],
                correctAnswerIndex: 0
            ),
            Question(
                text: "Who is the all-time top scorer in La Liga?",
                options: ["Lionel Messi", "Cristiano Ronaldo", "Telmo Zarra", "Raúl"],
                correctAnswerIndex: 0
            ),
            Question(
                text: "Which NFL quarterback has the most career passing yards?",
                options: ["Tom Brady", "Drew Brees", "Peyton Manning", "Brett Favre"],
                correctAnswerIndex: 1
            ),
            Question(
                text: "What is the highest score ever achieved in a single NBA game by a player?",
                options: ["81 points", "100 points", "70 points", "73 points"],
                correctAnswerIndex: 0
            ),
            Question(
                text: "Who was the youngest player to win the FIFA Ballon d'Or?",
                options: ["Lionel Messi", "Pele", "Kylian Mbappé", "Cristiano Ronaldo"],
                correctAnswerIndex: 2
            ),
            Question(
                text: "Which team won the English Premier League in the 2015-2016 season?",
                options: ["Chelsea", "Leicester City", "Manchester City", "Arsenal"],
                correctAnswerIndex: 1
            ),
            Question(
                text: "Which tennis player has won the most Wimbledon singles titles?",
                options: ["Roger Federer", "Serena Williams", "Pete Sampras", "Martina Navratilova"],
                correctAnswerIndex: 0
            ),
            Question(
                text: "In Formula 1, who holds the record for most World Championships?",
                options: ["Michael Schumacher", "Lewis Hamilton", "Sebastian Vettel", "Ayrton Senna"],
                correctAnswerIndex: 0
            ),
            Question(
                text: "Who holds the record for most goals in a single NHL season?",
                options: ["Wayne Gretzky", "Mario Lemieux", "Bobby Hull", "Brett Hull"],
                correctAnswerIndex: 0
            ),
            Question(
                text: "Which country won the Rugby World Cup in 2019?",
                options: ["South Africa", "New Zealand", "England", "Australia"],
                correctAnswerIndex: 0
            ),
            Question(
                text: "Who holds the record for most home runs in MLB history?",
                options: ["Barry Bonds", "Hank Aaron", "Babe Ruth", "Alex Rodriguez"],
                correctAnswerIndex: 0
            ),
            Question(
                text: "Which cyclist has won the most Tour de France titles?",
                options: ["Eddy Merckx", "Lance Armstrong", "Bernard Hinault", "Miguel Indurain"],
                correctAnswerIndex: 0
            ),
            Question(
                text: "Which country hosted the FIFA World Cup in 2018?",
                options: ["Brazil", "Russia", "Germany", "France"],
                correctAnswerIndex: 1
            )
        ]
        questions = Array(allQuestions.shuffled().prefix(5))
    }

    
    func answerSelected(_ index: Int) {
        if !quizEnded {
            if index == questions[currentQuestionIndex].correctAnswerIndex {
                score += 1
            }
            goToNextQuestion()
        }
    }
    
    func goToNextQuestion() {
        timer?.invalidate()
        timeRemaining = 15
        if currentQuestionIndex + 1 < questions.count {
            currentQuestionIndex += 1
            startTimer()
        } else {
            quizEnded = true
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] t in
            guard let self = self else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.answerSelected(-1) // skip question on timeout
                t.invalidate()
            }
        }
    }
    
    func restart() {
        score = 0
        currentQuestionIndex = 0
        quizEnded = false
        timeRemaining = 15
        startTimer()
    }
}
