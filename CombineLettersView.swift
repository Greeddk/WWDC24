//
//  CombineLettersView.swift
//  FeelTheHangeul
//
//  Created by Greed on 2/25/24.
//

import SwiftUI

struct CombineLettersView: View {
    
    let viewModel = CombineLettersViewModel()
    let ttsManager = TTSManager.shared
    
    let columns = [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)]

    @State var answer = ""
    @State var pickedType = 0
    @State var resultLetter = "감"
    @State var showing = false
    @State var isCorrect = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    VStack {
                        Text(self.resultLetter)
                            .font(.system(size: 150, weight: .bold))
                            .frame(height: 150)
                        
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
                    VStack(spacing: -20) {
                        HStack(spacing: -20) {
                            Image(viewModel.inputFirst.value)
                            Image(viewModel.inputSecond.value)
                        }
                        Image(viewModel.inputThird.value)
                    }
                    Spacer()
                    VStack {
                        Text("Writing Box")
                            .font(.headline)
                        //UIKit으로 커스텀 필요
                        TextField("", text: $answer)
                            .font(.system(size: 250))
                            .frame(width: 250, height: 250)
                            .border(.blue, width: 5)
                            .onChange(of: answer) { _ in
                                //TextField가 변했을 때 원하는 이벤트 작성 구간
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
                
                Picker("", selection: $pickedType) {
                    Text("first consonant").tag(0)
                    Text("middle vowel").tag(1)
                    Text("last consonant").tag(2)
                }
                .frame(width: 800)
                .pickerStyle(.segmented)
                
                
                ScrollView {
                    LazyVGrid(columns: columns) {
                        switch pickedType {
                        case 0:
                            ForEach(viewModel.cho, id: \.self) { value in
                                LetterCardView(letter: value)
                                    .frame(width: 200, height: 200)
                                    .background(value == viewModel.inputFirst.value ? .cyan : .white)
                                    .cornerRadius(20)
                                    .modifier(CardModifier())
                                    .onTapGesture {
                                        viewModel.inputFirst.value = value
                                        resultLetter = self.viewModel.output.value
                                    }
                            }
                        case 1:
                            ForEach(viewModel.jung, id: \.self) { value in
                                LetterCardView(letter: value)
                                    .frame(width: 200, height: 200)
                                    .background(value == viewModel.inputSecond.value ? .cyan : .white)
                                    .cornerRadius(20)
                                    .modifier(CardModifier())
                                    .onTapGesture {
                                        viewModel.inputSecond.value = value
                                        resultLetter = self.viewModel.output.value
                                    }
                            }
                        
                        case 2:
                            ForEach(viewModel.jong, id: \.self) { value in
                                LetterCardView(letter: value)
                                    .frame(width: 200, height: 200)
                                    .background(value == viewModel.inputThird.value ? .cyan : .white)
                                    .cornerRadius(20)
                                    .modifier(CardModifier())
                                    .onTapGesture {
                                        viewModel.inputThird.value = value
                                        resultLetter = self.viewModel.output.value
                                        print(value, resultLetter)
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

#Preview {
    CombineLettersView()
}
