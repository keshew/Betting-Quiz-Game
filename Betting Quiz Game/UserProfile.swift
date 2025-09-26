import Foundation

class UserProfile: ObservableObject {
    @Published var username: String = "Player"
    @Published var totalScore: Int {
        didSet {
            UserDefaults.standard.set(totalScore, forKey: "totalScore")
        }
    }
    @Published var achievements: [String] = []
    @Published var quizHistory: [Int] = []
//    @Published var purchasedItems: [UUID] = []
//
//    func buyItem(_ item: StoreItem) -> Bool {
//        if totalScore >= item.price && !purchasedItems.contains(item.id) {
//            totalScore -= item.price
//            purchasedItems.append(item.id)
//            return true
//        }
//        return false
//    }
    init() {
        self.totalScore = UserDefaults.standard.integer(forKey: "totalScore")
        if self.totalScore == 0 { self.totalScore = 100 } // стартовый баланс
    }

    func addScore(_ score: Int) {
        totalScore += score
        quizHistory.append(score)
        checkAchievements()
    }
    
    private func checkAchievements() {
        if totalScore >= 1000 && !achievements.contains("High Roller") {
            achievements.append("High Roller")
        }
        if quizHistory.filter({ $0 > 2 }).count >= 10 && !achievements.contains("Quiz Master") {
            achievements.append("Quiz Master")
        }
    }
}

