//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Peter Salz on 17.10.19.
//  Copyright © 2019 Peter Salz App Development. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = [
        "Estonia",
        "France",
        "Germany",
        "Ireland",
        "Italy",
        "Nigeria",
        "Poland",
        "Russia",
        "Spain",
        "UK",
        "US"
    ].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var scoreMessage = ""
    @State private var animateButtons = false
    @State private var rotationAmount = 0.0
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [.blue, .black]),
                           startPoint: .top,
                           endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        
            VStack(spacing: 30) {
                
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.animateButtons = true
                        if number == self.correctAnswer {
                            withAnimation {
                                self.rotationAmount += 360
                            }
                        }
                        self.flagTapped(number)
                    }) {
                        FlagImage(image: self.countries[number])
                    }
                    .opacity({
                        guard self.animateButtons else {
                            return 1.0
                        }
                        
                        return number == self.correctAnswer
                            ? 1.0
                            : 0.25
                    }())
                    .animation({
                        guard self.animateButtons else {
                            return nil
                        }
                        
                        guard number != self.correctAnswer else {
                            return nil
                        }
                        
                        return .easeIn
                    }())
                    .rotation3DEffect(
                        .degrees({
                            number == self.correctAnswer
                                ? self.rotationAmount
                                : 0.0
                        }()),
                        axis: (x: 0, y: 1, z: 0)
                    )
                }
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            
            Alert(title: Text(scoreTitle),
                  message: Text(scoreMessage),
                  dismissButton: .default(Text("Continue")) {
                        self.askQuestion()
                })
        }
    }
    
    func flagTapped(_ number: Int) {
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            scoreMessage = "Your score is \(score)"
        } else {
            scoreTitle = "Wrong"
            score -= 1
            scoreMessage = "That's the flag of \(countries[number])"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        animateButtons = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FlagModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        
        content
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct FlagImage: View {
    
    let image: String
    
    var body: some View {
        
        Image(image)
            .renderingMode(.original)
            .modifier(FlagModifier())
    }
}
