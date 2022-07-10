//
//  Solitare.swift
//  CardGames
//
//  Created by Porter McGary on 7/9/22.
//

import Foundation

class Solitare: Game, ObservableObject {
    @Published var deck: [PlayingCard] = fiftyTwoCardDeck()
    
    @Published var column1: [PlayingCard] = []
    @Published var column2: [PlayingCard] = []
    @Published var column3: [PlayingCard] = []
    @Published var column4: [PlayingCard] = []
    @Published var column5: [PlayingCard] = []
    @Published var column6: [PlayingCard] = []
    @Published var column7: [PlayingCard] = []
    
    @Published var spades: [PlayingCard] = []
    @Published var hearts: [PlayingCard] = []
    @Published var clubs: [PlayingCard] = []
    @Published var diamonds: [PlayingCard] = []
    
    let name: GameType = .solitare
    
    init() {
        deal()
    }
    
    public func deal() {
        deck = shuffle(deck: deck, shuffles: 10)
        let totalToDeal = 1 + 2 + 3 + 4 + 5 + 6 + 7
        
        for _ in 0..<totalToDeal {
            if column1.isEmpty {
                column1.append(deck.removeLast())
            }
            
            if column2.count < 2 {
                column2.append(deck.removeLast())
            }
            
            if column3.count < 3 {
                column3.append(deck.removeLast())
            }
            
            if column4.count < 4 {
                column4.append(deck.removeLast())
            }
            
            if column5.count < 5 {
                column5.append(deck.removeLast())
            }
            
            if column6.count < 6 {
                column6.append(deck.removeLast())
            }
            
            column7.append(deck.removeLast())
        }
    }
    
    public func validateMoveToColumn(from card1: PlayingCard, to card2: PlayingCard?) -> Bool {
        // Check colors
        guard let card2 = card2 else {
            // Only place Kings in empty column
            return card1.type == .king
        }
        
        guard checkColors(from: card1, to: card2) else { return false }
        guard isRankHigher(from: card1, to: card2) else { return false }
        return true
    }
    
    public func validateMoveToSuitStack(from card: PlayingCard, to suit: SuitType) -> Bool {
        var valid = false
        
        let stack = getStack(from: suit)
        let topCard: PlayingCard? = stack.last
        
        if let topCard = topCard {
            valid = isRankHigher(from: topCard, to: card)
        } else {
            valid = card.type == .ace
        }
        
        return valid
    }
    
    // Only place red cards on top of black
    // Only place black card on top of red
    private func checkColors(from: PlayingCard, to: PlayingCard) -> Bool {
        from.suit.color != to.suit.color
    }
    
    // Only place card type on top of one that immediately out ranks it
    private func isRankHigher(from: PlayingCard, to: PlayingCard) -> Bool {
        return from.type.isRankHigher(than: to.type)
    }
    
    private func getStack(from suit: SuitType) -> [PlayingCard] {
        switch suit {
        case .diamond:
            return diamonds
        case .heart:
            return hearts
        case .spade:
            return spades
        case .club:
            return clubs
        }
    }
}
