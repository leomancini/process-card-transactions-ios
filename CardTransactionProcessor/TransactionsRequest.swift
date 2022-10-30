//
//  TransactionsRequest.swift
//  CardTransactionProcessor
//
//  Created by Leo Mancini on 10/30/22.
//

import Foundation

class TransactionsAPI {
    func getTransactions(completion:@escaping ([Transaction]) -> ()) {
        let transactionsApiPassowrd = Bundle.main.object(forInfoDictionaryKey: "TRANSACTIONS_API_PASSWORD") as? String
        
        guard let password = transactionsApiPassowrd, !password.isEmpty else {
            print("API password does not exist")
            return
        }
        guard let url = URL(string: "http://localhost/process-card-transactions/admin/viewTransactions?password=" + password) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let transactions = try! JSONDecoder().decode([Transaction].self, from: data!)
            print(transactions)
            
            DispatchQueue.main.async {
                completion(transactions)
            }
        }
        .resume()
    }
}
