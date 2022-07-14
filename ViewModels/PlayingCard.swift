//
//  PlayingCard.swift
//  CardGames
//
//  Created by Porter McGary on 7/9/22.
//

import Foundation

class PlayingCard: ObservableObject, Identifiable {
    @Published var isFaceUp: Bool
    let id = UUID()
    let suit: SuitType
    let type: CardType
    
    init(suit: SuitType, type: CardType, isFaceUp: Bool = false) {
        self.isFaceUp = isFaceUp
        self.suit = suit
        self.type = type
    }
    
    static let example = PlayingCard(suit: .spade, type: .five, isFaceUp: true)
}
