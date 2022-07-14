//
//  CardStack.swift
//  CardGames
//
//  Created by Porter McGary on 7/10/22.
//

import SwiftUI

struct CardStack: View {
    @State private var cards: [PlayingCard] = Array(repeating: PlayingCard.example, count: 10)
    
    var body: some View {
        ZStack {
            ForEach(0..<cards.count, id: \.self) { index in
                PlayingCardView(card: cards[index])
                    .stacked(at: index, in: cards.count)
            }
        }
    }
}

struct CardStack_Previews: PreviewProvider {
    static var previews: some View {
        CardStack()
    }
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: offset * 2, y: 0)
    }
}
