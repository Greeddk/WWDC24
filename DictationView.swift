//
//  DictationView.swift
//  FeelTheHangeul
//
//  Created by Greed on 2/25/24.
//

import SwiftUI

struct DictationView: View {
    
    @Environment(\.dismiss) private var dismiss
    let viewModel = DictationViewModel()
    let ttsManager = TTSManager()
    
    @State var text = ""
    @State var answer = ""
    @State var isCorrect = false
    @State var showing = false
    @State var clearLevel = false
    @State var listIndex = 0
    @State var showHint = false
    @State var showAnswer = false
    @State var showModal = false
    
    var body: some View {
        VStack {
            Text("Click the Listen button to hear and dictate a word")
                .font(.largeTitle)
            Spacer()
            HStack {
                Button {
                    showHint.toggle()
                } label: {
                    Text(showHint ? "[ \(text.applyingTransform(.toLatin, reverse: false) ?? "") ]" : "Hint Button")
                        .font(.title)
                }
                .tint(.teal)
                .buttonStyle(.borderedProminent)
                .onAppear {
                    viewModel.list.shuffle()
                    text = viewModel.list[listIndex]
                }
                
                Button {
                    ttsManager.play(text)
                } label: {
                    Image(systemName: "speaker.wave.3")
                        .font(.system(size: 35))
                }
            }
            Spacer()
            VStack {
                Text("Writing Box")
                TextField("", text: $answer)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 150))
                    .foregroundColor(showAnswer ? .red : .black)
                    .frame(width: 500, height: 300)
                    .border(.yellow)
            }
            .alert(isPresented: $showing) {
                if clearLevel {
                    let defaultButton = Alert.Button.default(Text("OK")) {
                        dismiss()
                    }
                    return Alert(title: Text("Excellent!") , message: Text("Congratulations, you made it! If you're still confused, you're welcome to study more!"), dismissButton: defaultButton)
                }
                let defaultButton = Alert.Button.default(Text("OK")) {
                    showing = false
                    isCorrect = false
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                return Alert(title: Text(isCorrect ? "Good Job!" : "Try Again!") , message: Text(isCorrect ? "Let's practice other letter, too" : "You can do it! Write it again "), dismissButton: defaultButton)
            }
            
            Button {
                if text == answer {
                    print("정답")
                    isCorrect = true
                    if showAnswer {
                        isCorrect = false
                    }
                }
                showing = true
                answer = ""
                showAnswer = false
            } label: {
                Text("Submit")
            }
            .buttonStyle(.bordered)
            .tint(.mint)
            Spacer().frame(height: 50)
            Button {
                showAnswer = true
                answer = text
            } label: {
                HStack {
                    Text("Answer")
                    Image(systemName: "chevron.right")
                }
            }
            .buttonStyle(.bordered)
            .tint(.green)
            
            let list = getSeparatedChar(word: text)
            ScrollView(.horizontal) {
                HStack(spacing: -20) {
                    ForEach(list, id: \.self) { value in
                        Image(showAnswer ? value : "")
                    }
                }
            }
            .frame(height: 150)
            
            Spacer()
            Button {
                listIndex += 1
                showHint = false
                showAnswer = false
                answer = ""
                if listIndex == viewModel.list.count {
                    clearLevel = true
                    showing = true
                } else {
                    text = viewModel.list[listIndex]
                }
            } label: {
                HStack {
                    Text("Next Word")
                    Image(systemName: "chevron.right")
                }
            }
            .buttonStyle(.bordered)
            .tint(.blue)
            
        }
        .sheet(isPresented: $showModal) {
            DictationInfoModalView()
        }
        .toolbar {
            Button("Help") {
                showModal = true
            }
        }

    }
}

extension DictationView {
    func getSeparatedChar(word: String) -> [String] {
        switch word {
        case "고구마":
            return ["ㄱ", "ㅗ", "ㄱ", "ㅜ", "ㅁ", "ㅏ"]
        case "스키":
            return ["ㅅ", "ㅡ", "ㅋ", "ㅣ"]
        case "키위":
            return ["ㅋ", "ㅣ", "ㅇ", "ㅟ"]
        case "바나나":
            return ["ㅂ", "ㅏ", "ㄴ", "ㅏ", "ㄴ", "ㅏ"]
        case "토마토":
            return ["ㅌ", "ㅗ", "ㅁ", "ㅏ", "ㅌ", "ㅗ"]
        case "보트":
            return ["ㅂ", "ㅗ", "ㅌ", "ㅡ"]
        case "마우스":
            return ["ㅁ", "ㅏ", "ㅇ", "ㅜ", "ㅅ", "ㅡ"]
        case "노트북":
            return ["ㄴ", "ㅗ", "ㅌ", "ㅡ", "ㅂ", "ㅜ", "ㄱ"]
        case "컴퓨터":
            return ["ㅋ", "ㅓ", "ㅁ", "ㅍ", "ㅠ", "ㅌ", "ㅓ"]
        case "쿠키":
            return ["ㅋ", "ㅜ", "ㅋ", "ㅣ"]
        case "카드":
            return ["ㅋ", "ㅏ", "ㄷ", "ㅡ"]
        default:
            return [""]
        }
    }
    
    
}

struct DictationInfoModalView: View {
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
            Image("speaker")
                .resizable()
                .frame(width: 200, height: 100)
            Spacer().frame(height: 20)
            Text("First, press the sound button to listen the Korean word and write the answer. If you're not sure, hit the hint button to see how it's pronounced in English, then enter the correct answer and submit. If you really don't know, click the answer button to see the word and learn it! Try different combinations of consonants and vowels! You can also write the letters in the writing box using Apple pencil if you wanna check that you wrote them correctly. If you can't see the Korean characters as you write, try setting it up!")
                .frame(width: UIScreen.main.bounds.width * 2 / 3 )
            Spacer()
        }
    }
}

#Preview {
    DictationView()
}
