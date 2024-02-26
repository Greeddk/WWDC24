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
    
    let inputConsonant = CustomObservable("ㄱ")
    let inputVowel = CustomObservable("ㅏ")
    
    let outputConsonant = CustomObservable("ㄱ")
    let outputVowel = CustomObservable("ㅏ")
    
    init() {
        inputConsonant.bind { value in
            self.outputConsonant.value = value
        }
        inputVowel.bind { value in
            self.outputVowel.value = value
        }
    }
    
}
