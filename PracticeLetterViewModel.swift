//
//  PracticeLetterViewModel.swift
//  FeelTheHangeul
//
//  Created by Greed on 2/25/24.
//

import Foundation

class PracticeLetterViewModel {
    
    let consonants:[String] = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]

    let vowels:[String] = ["ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ", "ㅛ", "ㅜ", "ㅝ",
                            "ㅞ", "ㅟ", "ㅠ", "ㅡ", "ㅢ", "ㅣ"]
    
    let inputConsonant = Observable("ㄱ")
    let inputVowel = Observable("ㅏ")
    
    let outputConsonant = Observable("ㄱ")
    let outputVowel = Observable("ㅏ")
    
    init() {
        inputConsonant.bind { value in
            self.outputConsonant.value = value
        }
        inputVowel.bind { value in
            self.outputVowel.value = value
        }
    }
    
}
