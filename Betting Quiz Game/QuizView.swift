import SwiftUI

struct QuizView: View {
    @StateObject private var quizManager = QuizManager()
    @StateObject private var userProfile = UserProfile()

    @State private var showProfile = false
    @State private var isShareSheetPresented = false
    @State private var showBetting = true
    @State private var currentBet = 0

    var body: some View {
        NavigationStack {
            if showBetting {
                BettingView(userProfile: userProfile) { bet in
                    currentBet = bet
                    showBetting = false
                    quizManager.restart()
                }
            } else {
                VStack(spacing: 24) {
                    if quizManager.quizEnded {
                        Spacer()
                        VStack(spacing: 24) {
                            Text("🎉 Quiz Ended!")
                                .font(.largeTitle)
                                .bold()

                            Text("Your score: \(quizManager.score)/\(quizManager.questions.count)")
                                .font(.title2)
                                .foregroundColor(.blue)

                            let win = quizManager.score >= (quizManager.questions.count / 2)
                            Text(win ? "You won your bet!" : "You lost your bet.")
                                .font(.headline)
                                .foregroundColor(win ? .green : .red)

                            HStack(spacing: 20) {
                                Button(action: {
                                    isShareSheetPresented = true
                                }) {
                                    Label("Share Your Score", systemImage: "square.and.arrow.up")
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(12)
                                }

                                Button(action: {
                                    if win {
                                        userProfile.totalScore += currentBet
                                    } else {
                                        userProfile.totalScore -= currentBet
                                    }
                                    showBetting = true
                                }) {
                                    Label("Play Again", systemImage: "arrow.clockwise")
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .padding()
                                        .background(Color.green)
                                        .foregroundColor(.white)
                                        .cornerRadius(12)
                                }
                            }
                        }
                        Spacer()
                    } else {
                        // предыдущий UI викторины
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Question \(quizManager.currentQuestionIndex + 1) of \(quizManager.questions.count)")
                                .font(.headline)
                                .foregroundColor(.secondary)

                            Text(quizManager.questions[quizManager.currentQuestionIndex].text)
                                .font(.title3)
                                .bold()
                                .multilineTextAlignment(.leading)
                        }

                        VStack(spacing: 12) {
                            ForEach(0..<quizManager.questions[quizManager.currentQuestionIndex].options.count, id: \.self) { index in
                                Button(action: {
                                    quizManager.answerSelected(index)
                                }) {
                                    Text(quizManager.questions[quizManager.currentQuestionIndex].options[index])
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.gray.opacity(0.15))
                                        .cornerRadius(10)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }

                        HStack {
                            ProgressView(value: Double(quizManager.timeRemaining), total: 15)
                                .progressViewStyle(LinearProgressViewStyle(tint: .red))
                                .frame(height: 8)
                                .cornerRadius(4)
                            Text("\(quizManager.timeRemaining)s")
                                .foregroundColor(.red)
                                .font(.subheadline)
                                .bold()
                        }
                    }
                }
                .padding()
                .navigationTitle("Betting Quiz")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { showProfile.toggle() }) {
                            Image(systemName: "person.circle")
                                .font(.title2)
                        }
                    }
                }
                .sheet(isPresented: $showProfile) {
                    NavigationStack {
                        ProfileView(userProfile: userProfile)
                    }
                }
                .sheet(isPresented: $isShareSheetPresented) {
                    ShareSheet(activityItems: ["I scored \(quizManager.score) points in Betting Quiz Game! Try it!"])
                }
            }
        }
        .onChange(of: quizManager.quizEnded) { ended in
            if ended {
                userProfile.addScore(quizManager.score)
            }
        }
    }
}



#Preview {
    QuizView()
}
