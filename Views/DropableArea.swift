//
//  DropableArea.swift
//  CardGames
//
//  Created by Porter McGary on 7/10/22.
//

import SwiftUI

struct DropableArea<Content: View>: View {
    var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
    }
}

struct DropableArea_Previews: PreviewProvider {
    static var previews: some View {
        DropableArea {
            EmptyPlayingCardSlot()
        }
    }
}
