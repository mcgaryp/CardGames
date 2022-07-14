//
//  CardTable.swift
//  CardGames
//
//  Created by Porter McGary on 7/10/22.
//

import SwiftUI

struct CardTable: View {
    @StateObject var solitare = Solitare()
    
    var body: some View {
        Draggable {
            PlayingCardView(card: PlayingCard.example)
        }
    }
//        VStack {
//            HStack(spacing: 0) {
//                // Deck
//                PlayingCardView(card: previewBackOfCard)
//                // Discard
//
//                Spacer()
//                // Suits * 4
//                EmptyPlayingCardSlot(suit: .heart)
//                EmptyPlayingCardSlot(suit: .club)
//                EmptyPlayingCardSlot(suit: .diamond)
//                EmptyPlayingCardSlot(suit: .spade)
//            }
//            HStack(spacing: 0) {
//                // 7 Columns
//                PlayingCardView(card: previewCard)
//                PlayingCardView(card: previewCard)
//                EmptyPlayingCardSlot()
//                PlayingCardView(card: previewCard)
//                PlayingCardView(card: previewCard)
//                PlayingCardView(card: previewCard)
//                PlayingCardView(card: previewCard)
//            }
//            Spacer()
//        }
//        .padding(.top)
}

struct CardTable_Previews: PreviewProvider {
    static var previews: some View {
        CardTable()
    }
}

private let previewCard = PlayingCard(suit: .heart, type: .five, isFaceUp: true)
private let previewBackOfCard = PlayingCard(suit: .heart, type: .five)

struct EmptyPlayingCardSlot: View {
    var suit: SuitType?
    
    var body: some View {
        Group {
            if let suit = suit {
                Image(systemName: suit.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .frame(width: 50, height: 75)
                    .foregroundColor(suit.color)
                    .overlay {
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                    }
            } else {
                Color.white
                    .frame(width: 50, height: 75)
                    .overlay {
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                    }
            }
        }
        .padding(.horizontal, 2)
    }
}
