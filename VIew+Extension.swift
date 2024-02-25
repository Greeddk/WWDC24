//
//  UIVIew+Extension.swift
//  FeelTheHangeul
//
//  Created by Greed on 2/25/24.
//

import SwiftUI

extension View {
    func customLabel(text: String, description: String, color: Color) -> some View {
        RoundedRectangle(cornerRadius: 50)
            .foregroundColor(color)
            .overlay {
                VStack {
                    Text(text)
                        .font(.system(size: 120))
                        .foregroundColor(.white)
                    Text(description)
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                }
            }
            .frame(width: UIScreen.main.bounds.width - 50, height: UIScreen.main.bounds.height / 4)
            
    }
}

