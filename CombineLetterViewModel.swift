//
//  LetterGridViewModel.swift
//  Write Hangeul
//
//  Created by Greed on 2/23/24.
//

import Foundation

class CombineLettersViewModel {
    
    let cho:[String] = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]

    let jung:[String] = ["ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ", "ㅛ", "ㅜ", "ㅝ",
                            "ㅞ", "ㅟ", "ㅠ", "ㅡ", "ㅢ", "ㅣ"]
    let jong:[String] = [" ", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ",
                            "ㅀ", "ㅁ", "ㅂ", "ㅄ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
    
    var inputFirst = Observable("ㄱ")
    var inputSecond = Observable("ㅏ")
    var inputThird = Observable("ㅁ")
    
    var output = Observable("감")
    
    init() {
        inputFirst.bind { value in
            self.output.value = self.hangle(c1: value, c2: self.inputSecond.value, c3: self.inputThird.value)
        }
        inputSecond.bind { value in
            self.output.value = self.hangle(c1: self.inputFirst.value, c2: value, c3: self.inputThird.value)
        }
        inputThird.bind { value in
            self.output.value = self.hangle(c1: self.inputFirst.value, c2: self.inputSecond.value, c3: value)
            print(value)
        }
    }
    
    private func hangle(c1:String,c2:String,c3:String) -> String {
        var cho_i = 0
        var jung_i = 0
        var jong_i = 0
        for i in 0 ..< cho.count {
            if cho[i] == c1 { cho_i = i }
        }
        
        for i in 0 ..< jung.count {
            if jung[i] == c2 { jung_i = i }
        }
        
        for i in 0 ..< jong.count {
            if jong[i] == c3 { jong_i = i }
        }
        
        let uniValue:Int = (cho_i * 21 * 28) + (jung_i * 28) + (jong_i) + 0xAC00;
        if let uni = Unicode.Scalar(uniValue) {
            return String(uni)
        }
        
        return "none"
    }

}
