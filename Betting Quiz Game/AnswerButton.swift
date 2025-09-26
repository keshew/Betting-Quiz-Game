import SwiftUI

struct BettingView: View {
    @ObservedObject var userProfile: UserProfile
    var startQuiz: (Int) -> Void

    @State private var betAmountText = ""
    @State private var errorMessage = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Your balance: \(userProfile.totalScore) points")
                .font(.headline)
            TextField("Enter your bet amount", text: $betAmountText)
                .keyboardType(.numberPad)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            Button("Start Quiz with Bet") {
                if let bet = Int(betAmountText), bet > 0, bet <= userProfile.totalScore {
                    errorMessage = ""
                    startQuiz(bet)
                } else {
                    errorMessage = "Enter a valid bet within your balance."
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            Spacer()
        }
        .padding()
        .navigationTitle("Place Your Bet")
    }
}
