import SwiftUI

struct SelectLevelView: View {
    
    @State var showOnboarding: Bool = true
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Select Your Level")
                    .font(.system(size: 30, weight: .bold, design: .default))
                Spacer()
                NavigationLink(destination: PracticeLetterView()) {
                    customLabel(text: "Beginner", description: "You can learn how to write the basic consonants and vowels of Hangeul and how to pronounce them.", color: .cyan)
                }
                
                Spacer()
                NavigationLink(destination: CombineLettersView()) {
                    customLabel(text: "Intermediate", description: "You can learn how to combine consonants and vowels in Korean to make a letter, how to write them and pronounce them. (focusing on basic consonants)", color: .blue)
                }
                Spacer()
                NavigationLink(destination: DictationView()) {
                    customLabel(text: "Advanced", description: "You can learn how to write the basic consonants and vowels of Hangul and how to pronounce them.", color: .indigo)
                }
            }
            .padding()
        }
        .fullScreenCover(isPresented: $showOnboarding, content: {
            WalkThroughView(showOnboarding: $showOnboarding)
        })
    }
    
}

struct WalkThroughView: View {
    @Binding var showOnboarding: Bool
    var body: some View {
        TabView() {
            OnboardView(
                systemImageName: "mainImage", title: "Welcome", description: "Would you like to learn more about Hangeul?",
                showsDismissButton: false,
                showOnboarding: $showOnboarding, goToSettingPage: false
                
            )
            
            OnboardView(
                systemImageName: "collection", title: "Letters", description: "Korean words consist of an initial consonant and a vowel or sometimes a consonant placed under a vowel.",
                showsDismissButton: false,
                showOnboarding: $showOnboarding, goToSettingPage: false
            )
            
            OnboardView(
                systemImageName: "question", title: "How many...?", description: "The number of all letters in Hangeul is 11,172. Of course, there are many letters that are not used. The most frequently used letters are said to be 2,350.",
                showsDismissButton: false,
                showOnboarding: $showOnboarding, goToSettingPage: false
            )
            
            OnboardView(
                systemImageName: "setkeyboard", title: "Please add Korean Keyboard", description: "In order to learn Korean with this app, you need to use Apple Pencil to write Korean using the Scribble feature. To do so, please add Korean on keyboard to General in Settings.",
                showsDismissButton: false,
                showOnboarding: $showOnboarding, goToSettingPage: true
            )
            
            OnboardView(
                systemImageName: "level", title: "Let's select your level!", description: "Depending on your level, you can learn basic Hangeul consonants, vowels, and even dictate words!",
                showsDismissButton: true,
                showOnboarding: $showOnboarding, goToSettingPage: false
            )
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}


struct OnboardView: View {
    let systemImageName: String
    let title: String
    let description: String
    let showsDismissButton: Bool
    @Binding var showOnboarding: Bool
    var goToSettingPage: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            if systemImageName == "collection" || systemImageName == "setkeyboard" {
                Image(systemImageName)
                    .resizable()
                    .scaledToFit()
            } else {
                Image(systemImageName)
            }
            Spacer().frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            Text(title)
                .font(.title)
                .bold()
            Text(description)
                .font(.system(size: 20))
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            if goToSettingPage {
                Button {
                    //                    guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                    guard let url = NSURL(string:"App-prefs:root=General&path=Keyboard") as? URL else { return }
                    
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    Text("Go to Setting")
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(.green)
                        .cornerRadius(6)
                }
            }
            if showsDismissButton {
                Button {
                    showOnboarding.toggle()
                } label: {
                    Text("Get Started")
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(.green)
                        .cornerRadius(6)
                }
            }
        }
        .padding(.horizontal, 20)
    }
}
