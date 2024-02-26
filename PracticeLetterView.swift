//
//  PracticeLetterView.swift
//  FeelTheHangeul
//
//  Created by Greed on 2/25/24.
//

import SwiftUI

struct PracticeLetterView: View {
    
    let viewModel = PracticeLetterViewModel()
    let ttsManager = TTSManager.shared
    
    let columns = [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)]
    
    @State var answer = ""
    @State var pickedType = 0
    @State var resultConsonant = "ㄱ"
    @State var resultVowel = "ㅏ"
    @State var showing = false
    @State var isCorrect = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    VStack {
                        let text = pickedType == 0 ? resultConsonant : resultVowel
                        Text(text)
                            .font(.system(size: 150, weight: .bold))
                            .frame(height: 150)
                            .onAppear(perform: {
                                viewModel.inputConsonant.value = resultConsonant
                                viewModel.inputVowel.value = resultVowel
                            })
                        
                        HStack {
                            Text("[ \(text.applyingTransform(.toLatin, reverse: false) ?? "") ]")
                                .font(.system(size: 40))
                            Button {
                                ttsManager.play(text)
                            } label: {
                                Image(systemName: "speaker.wave.3")
                                    .font(.system(size: 35))
                            }
                        }
                        .frame(height: 50)
                        .frame(alignment: .bottom)
                    }
                    Spacer()
                    VStack {
                        let text = pickedType == 0 ? resultConsonant : resultVowel
                        Image(text)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250)
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
                                let text = pickedType == 0 ? resultConsonant : resultVowel
                                if text == answer {
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
                
                Picker("", selection: $pickedType) {
                    Text("consonants").tag(0)
                    Text("vowels").tag(1)
                }
                .pickerStyle(.segmented)
                
                
                ScrollView {
                    LazyVGrid(columns: columns) {
                        switch pickedType {
                        case 0:
                            ForEach(viewModel.consonants, id: \.self) { value in
                                LetterCardView(letter: value)
                                    .frame(width: 200, height: 200)
                                    .background(value == viewModel.inputConsonant.value ? .cyan : .white)
                                    .cornerRadius(20)
                                    .modifier(CardModifier())
                                    .onTapGesture {
                                        viewModel.inputConsonant.value = value
                                        resultConsonant = self.viewModel.inputConsonant.value
                                    }
                            }
                        case 1:
                            ForEach(viewModel.vowels, id: \.self) { value in
                                LetterCardView(letter: value)
                                    .frame(width: 200, height: 200)
                                    .background(value == viewModel.outputVowel.value ? .cyan : .white)
                                    .cornerRadius(20)
                                    .modifier(CardModifier())
                                    .onTapGesture {
                                        viewModel.inputVowel.value = value
                                        resultVowel = self.viewModel.outputVowel.value
                                    }
                            }
                        default:
                            Text("")
                        }
                        
                    }
                    
                    
                }
            }
        }
    }
    
}

struct InfoModalView: View {
    var body: some View {
        VStack {
            Image("")
            Text("You can click on the consonants and vowels to study how they sound and what the stroke order is like. You can also write the letters in the writing box using Apple pencil if you wanna check that you wrote them correctly. If you can't see the Korean characters as you write, try setting it up like the picture below!")
            Image("")
        }
    }
}
