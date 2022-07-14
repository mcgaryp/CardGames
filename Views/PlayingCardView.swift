//
//  PlayingCardView.swift
//  CardGames
//
//  Created by Porter McGary on 7/9/22.
//

import SwiftUI

struct PlayingCardView: View {
    @StateObject var card: PlayingCard
    let size: CGFloat = 10
    
    private var suitImage: some View {
        Image(systemName: card.suit.image)
            .resizable()
            .frame(width: size, height: size)
            .aspectRatio(contentMode: .fit)
    }
    
    private var invisibleImage: some View {
        Image(systemName: card.suit.image)
            .resizable()
            .frame(width: size, height: size)
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.clear)
    }
    
    private var header: some View {
        VStack(spacing: 0) {
            Text(card.type.rawValue)
            if !isJoker {
                Image(systemName: card.suit.image)
            }
            Spacer()
        }
        .font(Font.system(size: 5))
        .padding([.top, .leading], 1)
    }
    
    private var outsideColumn: some View {
        VStack(spacing: 0) {
            if isFaceCard {
                // Do nothing
            } else if isGreaterThan8 {
                suitImage
                Spacer()
                suitImage
                Spacer()
                suitImage.rotationEffect(.radians(.pi))
                Spacer()
                suitImage.rotationEffect(.radians(.pi))
            } else {
                image(isGreaterThan3)
                Spacer()
                image(isGreaterThan5)
                Spacer()
                image(isGreaterThan3).rotationEffect(.radians(.pi))
            }
        }
    }
    
    private var centerColumn: some View {
        VStack(spacing: 0) {
            if isFaceCard {
                Image(systemName: card.suit.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else if isGreaterThan8 {
                Spacer()
                image(isGreaterThan8)
                Spacer()
                invisibleImage
                Spacer()
                image(isTen).rotationEffect(.radians(.pi))
                Spacer()
            } else if isGreaterThan5 {
                Spacer()
                image(isGreaterThan6)
                Spacer()
                image(isEight).rotationEffect(.radians(.pi))
                Spacer()
            } else {
                image(isLessThan4)
                Spacer()
                image(isOdd)
                Spacer()
                image(isLessThan4).rotationEffect(.radians(.pi))
            }
        }
    }
    
    @ViewBuilder
    private func image(_ show: Bool) -> some View {
        if show {
            suitImage
        } else {
            invisibleImage
        }
    }
    
    private var joker: some View {
        Group {
            Spacer()
            Text("JOKER")
            Spacer()
        }
    }
    
    var body: some View {
        HStack(spacing: 0) {
            header
            
            if isJoker {
                joker
            } else {
                Group {
                    outsideColumn
                    centerColumn
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    outsideColumn
                }
                .padding(.vertical, 4)
            }
            
            header
                .rotationEffect(.radians(.pi))
        }
        .foregroundColor(card.suit.color)
        .font(.largeTitle)
        .background(Color.white)
        .cornerRadius(3)
        .frame(width: 50, height: 75) // ratio w:h 1 : 5/3 or h:w 1 : 2/3
        .padding(.horizontal, 2)
        .shadow(radius: 1)
        .overlay {
            if !card.isFaceUp {
                RoundedRectangle(cornerRadius: 3)
                    .frame(width: 50, height: 75)
                    .foregroundColor(.red)
            }
        }
    }
}

private extension PlayingCardView {
    var isJoker: Bool { card.type == .joker }
    var isFaceCard: Bool { card.type.isRankHigher(than: .ten, style: .aceHigh) }
    var isGreaterThan3: Bool { card.type.isRankHigher(than: .three) }
    var isGreaterThan5: Bool { card.type.isRankHigher(than: .five) }
    var isGreaterThan6: Bool { card.type.isRankHigher(than: .six) }
    var isGreaterThan8: Bool { card.type.isRankHigher(than: .eight) }
    var isLessThan4: Bool { card.type.isRankLower(than: .four)}
    var isOdd: Bool { card.type.isOdd() }
    var isSeven: Bool { card.type == .seven }
    var isEight: Bool { card.type == .eight }
    var isTen: Bool { card.type == .ten }
}

struct PlayingCardViewPreviews: PreviewProvider {
    static var previews: some View {
        PlayingCardView(card: PlayingCard(suit: .club, type: .nine))
    }
}
