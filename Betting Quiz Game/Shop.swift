//import SwiftUI
//
//struct StoreView: View {
//    @ObservedObject var userProfile: UserProfile
//
//    let items: [StoreItem] = [
//        StoreItem(name: "Extra Time", description: "Get 5 extra seconds per question", price: 50),
//        StoreItem(name: "Skip Question", description: "Skip one question without penalty", price: 100),
//        StoreItem(name: "Double Points", description: "Double your points for next quiz", price: 150)
//    ]
//
//
//    // При показе алерта
//    @State var alertMessage = AlertMessage(message: "You bought")
//    @State private var showAlert = false
//    
//    var body: some View {
//        NavigationStack {
//            List(items) { item in
//                HStack {
//                    VStack(alignment: .leading) {
//                        Text(item.name).bold()
//                        Text(item.description).font(.caption).foregroundColor(.gray)
//                    }
//                    Spacer()
//                    Text("\(item.price) pts")
//                        .bold()
//                    Button("Buy") {
//                        if userProfile.buyItem(item) {
//                            alertMessage.message = "You bought \(item.name)!"
//                            showAlert = true
//                        } else {
//                            alertMessage.message = "Not enough points or already owned."
//                        }
//                    }
//                    .disabled(userProfile.purchasedItems.contains(item.id) || userProfile.totalScore < item.price)
//                    .buttonStyle(.borderedProminent)
//                }
//            }
//            .navigationTitle("Store")
//            .alert(alertMessage.message, isPresented: $showAlert) {
//                Button("OK", role: .cancel) { }
//            }
//        }
//    }
//}
//
//struct AlertMessage: Identifiable {
//    var id = UUID()
//    var message: String
//}
