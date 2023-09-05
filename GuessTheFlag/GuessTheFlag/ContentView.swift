//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Kirill Sivokhin on 31.08.2023.
//

import SwiftUI

struct FlagImage: View {
    var number: Int
    var countries: [String]
    
    var body: some View {
        Image(countries[number])
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 50)
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var showingWinningAlert = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var spinAmount = 0.0
    @State private var flagsTapped = [false, false, false]
    @State private var flagsChosen = [false, false, false]
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            withAnimation(.interpolatingSpring(stiffness: 5, damping: 2)) {
                                flagsTapped[number].toggle()
                                spinAmount += 360
                            }
                            
                            withAnimation(.easeInOut(duration: 2)) {
                                for i in 0..<flagsChosen.count {
                                    if i != number {
                                        flagsChosen[i].toggle()
                                    }
                                }
                            }
                        }
                        label: {
                            FlagImage(number: number, countries: countries)
                        }
                        .opacity(flagsChosen[number] ? 0.25 : 1)
                        .scaleEffect(flagsChosen[number] ? .zero : 1)
                        .rotation3DEffect(flagsTapped[number] ? .degrees(spinAmount) : .zero,
                                          axis: (x: 0, y: 1, z: 0))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            if scoreTitle == "Wrong" {
                Text("Your score is \(score)\nIt was \(countries[correctAnswer])")
            }
            else {
                Text("Your score is \(score)\nGood job!")
            }
        }
        .alert("You Won", isPresented: $showingWinningAlert) {
            Button("Start again", action: reset)
        } message: {
            Text("Final score is \(score)")
        }
    }
    
    func reset() {
        score = 0
        askQuestion()
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        }
        else {
            scoreTitle = "Wrong"
            score = 0
        }
        
        if score == 8 {
            showingWinningAlert = true
        }
        else {
            showingScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        flagsTapped = [false, false, false]
        flagsChosen = [false, false, false]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
