//
//  LetterCardView.swift
//  FeelTheHangeul
//
//  Created by Greed on 2/25/24.
//

import SwiftUI

struct LetterCardView: View {
    var letter: String
    var body: some View {
        Text(letter)
            .font(letter == "empty" ? .system(size: 30) : .system(size: 110, weight: .black))
    }
}

