//
//  CombineLettersView.swift
//  FeelTheHangeul
//
//  Created by Greed on 2/25/24.
//

import SwiftUI

struct CombineLettersView: View {
    
    let ttsManager = TTSManager.shared
    
    let cho:[String] = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]
    let jung:[String] = ["ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ", "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ", "ㅡ", "ㅢ", "ㅣ"]
    let jong:[String] = ["empty", "ㄱ", "ㄲ", "no", "ㄴ", "no", "no", "ㄷ", "ㄹ", "no", "no", "no", "no", "no", "no", "no", "ㅁ", "ㅂ", "no", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
    
    let columns = [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)]
    
    @State var answer = ""
    @State var pickedType = 0
    @State var resultLetter = ""
    @State var showing = false
    @State var isCorrect = false
    @State var inputFirst = "ㅎ"
    @State var inputSecond = "ㅏ"
    @State var inputThird = "ㄴ"
    @State var showModal = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    VStack {
                        Text(self.resultLetter)
                            .font(.system(size: 150, weight: .bold))
                            .frame(height: 150)
                            .onAppear {
                                resultLetter = hangle(c1: inputFirst, c2: inputSecond, c3: inputThird)
                            }
                        
                        HStack {
                            Text("[ \(resultLetter.applyingTransform(.toLatin, reverse: false) ?? "") ]")
                                .font(.system(size: 40))
                            Button {
                                ttsManager.play(resultLetter)
                            } label: {
                                Image(systemName: "speaker.wave.3")
                                    .font(.system(size: 35))
                            }
                        }
                        .frame(height: 50)
                        .frame(alignment: .bottom)
                    }
                    Spacer()
                    VStack(spacing: -40) {
                        HStack(spacing: -40) {
                            Image(inputFirst)
                            Image(inputSecond)
                        }
                        Image(inputThird)
                    }
                    Spacer()
                    VStack {
                        Text("Writing Box")
                            .font(.headline)
                        TextField("", text: $answer)
                            .font(.system(size: 250))
                            .frame(width: 250, height: 250)
                            .border(.blue, width: 5)
                            .onChange(of: answer) { _ in
                                if resultLetter == answer {
                                    print("정답")
                                    isCorrect = true
                                }
                                showing = true
                                DispatchQueue.global().async {
                                    sleep(1)
                                    self.answer = ""
                                }
                            }
                    }
                    Spacer()
                }
                .frame(height: 300)
                .alert(isPresented: $showing) {
                    let defaultButton = Alert.Button.default(Text("OK")) {
                        showing = false
                        isCorrect = false
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                    return Alert(title: Text(isCorrect ? "Good Job!" : "Try Again!") , message: Text(isCorrect ? "Let's practice other letter, too" : "You can do it! Write it again "), dismissButton: defaultButton)
                }
                
                Picker("select", selection: $pickedType) {
                    Text("first consonant").tag(0)
                    Text("middle vowel").tag(1)
                    Text("last consonant").tag(2)
                }
                .pickerStyle(.segmented)
                ScrollView {
                    if pickedType == 0 {
                        LazyVGrid(columns: columns) {
                            ForEach(cho, id: \.self) { value in
                                LetterCardView(letter: value)
                                    .frame(width: 200, height: 200)
                                    .background(value == inputFirst ? .cyan : .white)
                                    .cornerRadius(20)
                                    .modifier(CardModifier())
                                    .onTapGesture {
                                        print(1)
                                        inputFirst = value
                                        resultLetter = hangle(c1: value, c2: inputSecond, c3: inputThird)
                                    }
                            }
                        }
                    } else if pickedType == 1 {
                        LazyVGrid(columns: columns) {
                            ForEach(jung, id: \.self) { value in
                                LetterCardView(letter: value)
                                    .frame(width: 200, height: 200)
                                    .background(value == inputSecond ? .cyan : .white)
                                    .cornerRadius(20)
                                    .modifier(CardModifier())
                                    .onTapGesture {
                                        inputSecond = value
                                        resultLetter = hangle(c1: inputFirst, c2: value, c3: inputThird)
                                    }
                            }
                        }
                    } else {
                        let list = jong.filter { $0 != "no"}
                        LazyVGrid(columns: columns) {
                            ForEach(list, id: \.self) { value in
                                LetterCardView(letter: value)
                                    .frame(width: 200, height: 200)
                                    .background(inputThird == value ? .cyan : .white)
                                    .cornerRadius(20)
                                    .modifier(CardModifier())
                                    .onTapGesture {
                                        print(2)
                                        inputThird = value
                                        resultLetter = hangle(c1: inputFirst, c2: inputSecond, c3: value)
                                    }
                            }
                        }
                    }
                    
                }
            }
            .sheet(isPresented: self.$showModal) {
                CombineInfoModalView()
            }
            .toolbar {
                Button("Help") {
                    showModal = true
                }
            }
        }
    }
    
}

extension CombineLettersView {
    func hangle(c1:String,c2:String,c3:String) -> String {
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

struct CombineInfoModalView: View {
    @Environment(\.presentationMode) var presentation
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    presentation.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "x.circle")
                }.frame(width: 50, height: 50)
            }
            Spacer()
            Image("collection")
                .resizable()
                .scaledToFit()
            Spacer().frame(height: 20)
            Text("Korean words consist of an initial consonant and a vowel or sometimes a consonant placed under a vowel. You can click on the consonants and vowels to study how they sound and what the stroke order is like. You can also write the letters in the writing box using Apple pencil if you wanna check that you wrote them correctly. If you can't see the Korean characters as you write, try setting it up!")
                .frame(width: UIScreen.main.bounds.width * 2 / 3 )
            Spacer()
        }
    }
}

#Preview {
    CombineLettersView()
}
