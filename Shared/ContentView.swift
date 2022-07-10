//
//  ContentView.swift
//  Shared
//
//  Created by Porter McGary on 7/9/22.
//

import SwiftUI

struct ContentView: View {
    @State private var card: CardType = .ace
    @State private var suit: SuitType = .heart
    @State private var suitType: Float = 0.0
    @State private var cardType: Float = 0.0
    
    var body: some View {
        PlayingCardView(type: card, suit: suit)
        
        Group {
            Slider(value: $suitType, in: 0...Float(SuitType.allCases.count - 1), onEditingChanged: updateSuit) { Text("Suit") }
            Text("Suit: \(suit.rawValue)")
            Slider(value: $cardType, in: 0...Float(CardType.allCases().count - 1), onEditingChanged: updateCard) { Text("Card") }
            Text("Card: \(card.rawValue)")
        }
        .padding(.horizontal)
    }
    
    private func updateSuit(_ update: Bool) {
        suit = SuitType.allCases[Int(suitType)]
    }

    private func updateCard(_ update: Bool) {
        card = CardType.allCases()[Int(cardType)]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
