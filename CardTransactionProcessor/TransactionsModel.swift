//
//  TransactionsModel.swift
//  CardTransactionProcessor
//
//  Created by Leo Mancini on 10/30/22.
//

import SwiftUI

struct Transaction: Codable, Identifiable, Hashable {
    let id = UUID()
    let merchant: String
    let datetimeReadable: String
    let amount: Float
    
    enum CodingKeys: String, CodingKey {
        case merchant, datetimeReadable, amount
    }
}
