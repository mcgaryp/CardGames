//
//  Draggable.swift
//  CardGames
//
//  Created by Porter McGary on 7/10/22.
//

import SwiftUI

struct Draggable<Content: View>: View {
    @GestureState private var startLocation: CGPoint? = nil
    @State var offset: CGSize = .zero
    var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                offset = value.translation
            }
            .onEnded { _ in
                offset = .zero
            }
    }
    
    var body: some View {
        ZStack {
            content
                .offset(offset)
                .gesture(simpleDrag)
        }
    }
}

struct Draggable_Previews: PreviewProvider {
    static var previews: some View {
        Draggable {
            PlayingCardView(card: PlayingCard.example)
        }
    }
}

