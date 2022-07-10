//
//  PlayingCard.swift
//  CardGames
//
//  Created by Porter McGary on 7/9/22.
//

import Foundation

class PlayingCard: ObservableObject {
    let suit: SuitType
    let type: CardType
    @Published var faceup: Bool = false
    
    init(suit: SuitType, type: CardType) {
        self.suit = suit
        self.type = type
    }
}
