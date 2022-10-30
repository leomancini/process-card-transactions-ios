import SwiftUI

struct RoundedRectangleButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      Spacer()
        configuration.label
            .foregroundColor(.white)
            .font(
                .body
                .weight(.semibold)
            )
      Spacer()
    }
    .padding(12)
    .background(Color.blue.cornerRadius(8))
    .scaleEffect(configuration.isPressed ? 0.95 : 1)
  }
}

struct ContentView: View {
    @State var transactions: [Transaction] = []

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    Spacer()
                    ForEach(transactions, id: \.self) { transaction in
                        VStack {
                            VStack {
                                Text(transaction.merchant)
                                    .foregroundColor(.black)
                                    .font(
                                        .title3
                                        .weight(.semibold)
                                    )
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .leading
                                    )
                                Text("$" + String(transaction.amount))
                                    .foregroundColor(.gray)
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .leading
                                    )
                                Spacer(minLength: 32)
                                HStack {
                                    Button("Add to list") { }
                                        .buttonStyle(RoundedRectangleButtonStyle())
                                    Spacer(minLength: 16)
                                    Button("Split cost") { }
                                        .buttonStyle(RoundedRectangleButtonStyle())
                                }
                            }
                            .padding(20)
                        }
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .topLeading
                        )
                        .background(
                            RoundedRectangle(
                                cornerRadius: 16,
                                style: .continuous
                            )
                            .fill(Color.white)
                        )
                    }
                    .padding([.leading, .trailing], 16)
                    .padding(.bottom, 16)
                }
                .toolbarColorScheme(.light, for: .navigationBar)
                .preferredColorScheme(.dark)
                .padding(.top, 16)
            }
        }
        .onAppear {
            TransactionsAPI().getTransactions { (transactions) in
                self.transactions = transactions
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
