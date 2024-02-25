//
//  CardModifier.swift
//  FeelTheHangeul
//
//  Created by Greed on 2/25/24.
//

import SwiftUI

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .shadow(color: .gray, radius: 2, x: 2, y: 2)
                    .opacity(0.3)
            )
    }
}
