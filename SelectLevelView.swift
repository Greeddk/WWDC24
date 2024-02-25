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
            //            .navigationTitle(" g")
        }
        //        .fullScreenCover(isPresented: $showOnboarding, content: {
        //            WalkThroughView(showOnboarding: $showOnboarding)
        //        })
    }
    
}

struct WalkThroughView: View {
    @Binding var showOnboarding: Bool
    var body: some View {
        TabView() {
            OnboardView(
                systemImageName: "🎾", title: "Welcome", description: "Get an in-depth look at Tennis Racket",
                showsDismissButton: false,
                showOnboarding: $showOnboarding
                
            )
            OnboardView(
                systemImageName: "platter.2.filled.ipad.landscape", title: "Landscape", description: "Korean words consist of an initial consonant and a vowel or sometimes a consonant placed under a vowel.",
                showsDismissButton: false,
                showOnboarding: $showOnboarding
            )
            
            OnboardView(
                systemImageName: "racket", title: "Wow 😮", description: "A tennis racket has quite a few detailed characteristics.",
                showsDismissButton: false,
                showOnboarding: $showOnboarding
            )
            
            OnboardView(
                systemImageName: "sidebar.left", title: "Let's take a quick look at!", description: "Open the left sidebar and choose!",
                showsDismissButton: true,
                showOnboarding: $showOnboarding
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
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 180)
            Text(title)
                .font(.title)
                .bold()
            Text(description)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
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
