//
//  Suit.swift
//  CardGames
//
//  Created by Porter McGary on 7/9/22.
//

import Foundation
import SwiftUI

protocol Game {
    var name: GameType { get }
    var deck: [PlayingCard] { get set }
    
    func shuffle(deck cards: [PlayingCard], shuffles: Int) -> [PlayingCard]
}

enum GameState {
    case loading
    case awaiting
    case playersTurn
}

enum GameType {
    case solitare
}

extension Game {
    static func fiftyTwoCardDeck() -> [PlayingCard] {
        var deck: [PlayingCard] = []
        for suit in SuitType.allCases {
            for type in CardType.allCases(style: .kingHigh) {
                let card = PlayingCard(suit: suit, type: type)
                deck.append(card)
            }
        }
        return deck
    }
    
    static func fiftyFourCardDeck() -> [PlayingCard] {
        var deck: [PlayingCard] = []
        for suit in SuitType.allCases {
            for type in CardType.allCases(style: .jokerHigh) {
                let card = PlayingCard(suit: suit, type: type)
                deck.append(card)
            }
        }
        return deck
    }
    
    func shuffle(deck cards: [PlayingCard], shuffles: Int = 1) -> [PlayingCard] {
        guard shuffles > 1 else { return cards.shuffled() }
        var deck: [PlayingCard] = cards
        for _ in 0..<shuffles {
            deck = deck.shuffled()
        }
        return deck
    }
}

enum SuitType: String, CaseIterable {
    case spade = "Spade"
    case heart = "Heart"
    case club = "Club"
    case diamond = "Diamond"
}

extension SuitType {
    var color: Color {
        switch self {
        case .club, .spade:
            return .black
        case .heart, .diamond:
            return .red
        }
    }
    
    var image: String {
        switch self {
        case .spade:
            return "suit.spade.fill"
        case .heart:
            return "suit.heart.fill"
        case .club:
            return "suit.club.fill"
        case .diamond:
            return "suit.diamond.fill"
        }
    }
}

enum CardType: String {
    case ace = "A"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case ten = "10"
    case jack = "J"
    case queen = "Q"
    case king = "K"
    case joker = "$"
    
    enum StyleType {
        case kingHigh
        case aceHigh
        case jokerHigh
    }
}

extension CardType {
    
    static func allCases(style: StyleType = .kingHigh) -> [CardType] {
        switch style {
        case .kingHigh:
            return kingHigh
        case .aceHigh:
            return aceHigh
        case .jokerHigh:
            return jokerHigh
        }
    }
    
    private static let kingHigh: [CardType] = [
        .ace, .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .jack,. queen, .king]
    
    private static let aceHigh: [CardType] = [
        .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .jack,. queen, .king, .ace]
    
    private static let jokerHigh: [CardType] = [
        .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .jack,. queen, .king, .ace, .joker]
    
    func isRankHigher(than lhs: CardType, style: StyleType = .kingHigh) -> Bool {
        guard let fromRank: Int = CardType.allCases(style: style).firstIndex(of: self),
              let toRank: Int = CardType.allCases(style: style).firstIndex(of: lhs) else {
                  return false
              }
        
        return fromRank > toRank
    }
    
    func isRankLower(than lhs: CardType, style: StyleType = .kingHigh) -> Bool {
        guard let fromRank: Int = CardType.allCases(style: style).firstIndex(of: self),
              let toRank: Int = CardType.allCases(style: style).firstIndex(of: lhs) else {
                  return false
              }
        
        return fromRank < toRank
    }
    
    func isOdd(style: StyleType = .kingHigh) -> Bool {
        guard let rank: Int = CardType.allCases().firstIndex(of: self) else { return false }
        return (1 + rank).isOdd
    }
    
    func isEven(style: StyleType = .kingHigh) -> Bool {
        guard let rank: Int = CardType.allCases().firstIndex(of: self) else { return false }
        return (1 + rank).isEven
    }
}

extension Int {
    var isOdd: Bool {
        self % 2 == 1
    }
    
    var isEven: Bool {
        self % 2 == 0
    }
}
