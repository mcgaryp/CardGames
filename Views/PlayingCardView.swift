//
//  PlayingCardView.swift
//  CardGames
//
//  Created by Porter McGary on 7/9/22.
//

import SwiftUI

struct PlayingCardView: View {
    @ScaledMetric(relativeTo: .largeTitle) private var padding = 40.0
    
    let type: CardType
    let suit: SuitType
    
    private var suitImage: some View {
        Image(systemName: suit.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
    private var invisibleImage: some View {
        Image(systemName: suit.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.clear)
    }
    
    private var header: some View {
        VStack {
            Text(type.rawValue)
            if !isJoker {
                Image(systemName: suit.image)
            }
            Spacer()
        }
    }
    
    private var outsideColumn: some View {
        VStack {
            if isFaceCard {
                // Do Nothing
            } else if isGreaterThan3 {
                if isPosition1 {
                    suitImage
                    Spacer()
                }
                if isPosition2 {
                    suitImage
                    Spacer()
                }
                if isPosition3 {
                    suitImage
                        .rotationEffect(.radians(.pi))
                    Spacer()
                }
                if  isPosition4 {
                    suitImage
                        .rotationEffect(.radians(.pi))
                }
            } else {
                invisibleImage
            }
        }
    }
    
    private var centerColumn: some View {
        VStack {
            if isGreaterThan3 {
                Spacer()
            }
            
            if isPosition5 {
                suitImage
                Spacer()
            }
            
            if isPosition6 {
                suitImage
            } else {
                invisibleImage
            }
            
            if isPosition7 {
                Spacer()
                suitImage
                    .rotationEffect(.radians(.pi))
            }
            
            if isGreaterThan3 {
                Spacer()
            }
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
        HStack {
            header
            
            if isJoker {
                joker
            } else {
                Group {
                    outsideColumn
                    centerColumn
                    outsideColumn
                }
                .padding(.vertical, padding)
            }
                header
                    .rotationEffect(.radians(.pi))
        }
        .foregroundColor(suit.color)
        .padding()
        .cornerRadius(10)
        .font(.largeTitle)
    }
}

private extension PlayingCardView {
    var isPosition7: Bool { (isEvenAndGreater7 || type == .three || type == .two) && !isFaceCard }
    var isPosition6: Bool { isOddAndNot7 || isFaceCard }
    var isPosition5: Bool { (isPosition7 || type == .seven) && !isFaceCard }
    var isPosition4: Bool { isGreaterThan3 }
    var isPosition3: Bool { isGreaterThan8 }
    var isPosition2: Bool { isGreaterThan5 }
    var isPosition1: Bool { isGreaterThan3 }
    
    var isJoker: Bool { type == .joker }
    var isFaceCard: Bool { type.isRankHigher(than: .ten, style: .aceHigh) }
    var isGreaterThan3: Bool { type.isRankHigher(than: .three) }
    var isGreaterThan5: Bool { type.isRankHigher(than: .five) }
    var isEvenAndGreater7: Bool { type.isEven() && type.isRankHigher(than: .seven) }
    var isGreaterThan8: Bool { type.isRankHigher(than: .eight) }
    var isOddAndNot7: Bool { type.isOdd() && type != .seven }
}

struct PlayingCardViewPreviews: PreviewProvider {
    static var previews: some View {
        PlayingCardView(type: .ace, suit: .heart)
    }
}
