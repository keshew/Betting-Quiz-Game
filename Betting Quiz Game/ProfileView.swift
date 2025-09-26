import SwiftUI

struct ProfileView: View {
    @ObservedObject var userProfile: UserProfile

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Username")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(userProfile.username)
                        .font(.largeTitle)
                        .bold()
                }

                VStack(alignment: .leading, spacing: 16) {
                    Text("Total Score")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("\(userProfile.totalScore)")
                        .font(.title)
                        .bold()
                        .foregroundColor(.blue)
                }

                VStack(alignment: .leading, spacing: 16) {
                    Text("Achievements")
                        .font(.headline)
                        .padding(.bottom, 5)

                    if userProfile.achievements.isEmpty {
                        Text("No achievements yet. Play more to unlock!")
                            .italic()
                            .foregroundColor(.gray)
                    } else {
                        ForEach(userProfile.achievements, id: \.self) { achievement in
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                Text(achievement)
                                    .font(.body)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Profile")
    }
}

import UIKit
import SwiftUI

struct ShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
