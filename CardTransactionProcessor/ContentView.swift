import SwiftUI

struct ActionButton: ButtonStyle {
    var backgroundColor: Color;
    
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
        .background(backgroundColor.cornerRadius(32))
        .scaleEffect(configuration.isPressed ? 0.85 : 1)
        .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
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
                                Spacer()
                                Text(String(transaction.datetimeReadable))
                                    .foregroundColor(.gray)
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .leading
                                    )
                                Spacer(minLength: 16)
                                Text("$" + String(transaction.amount))
                                    .foregroundColor(.black)
                                    .font(
                                        .body
                                        .weight(.medium)
                                    )
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .leading
                                    )
                                Spacer(minLength: 16)
                                HStack {
                                    Button("Save") { }
                                        .buttonStyle(ActionButton(backgroundColor: .blue))
                                    Spacer(minLength: 16)
                                    Button("Split") { }
                                        .buttonStyle(ActionButton(backgroundColor: .green))
                                    Spacer(minLength: 16)
                                    Button("Ignore") { }
                                        .buttonStyle(ActionButton(backgroundColor: .red))
                                }
                            }
                            .padding(28)
                        }
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .topLeading
                        )
                        .background(
                            RoundedRectangle(
                                cornerRadius: 40,
                                style: .continuous
                            )
                            .fill(Color.white)
                        )
                    }
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
        .refreshable {
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
