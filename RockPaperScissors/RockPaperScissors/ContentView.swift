//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Kirill Sivokhin on 02.09.2023.
//

import SwiftUI

struct ContentView: View {
    let possibleMoves = ["Rock", "Paper", "Scissors"]
    let winningMoves = ["Paper", "Scissors", "Rock"]
    let losingMoves = ["Scissors", "Rock", "Paper"]
    
    @State private var appsChoice = 0
    @State private var playerShouldWin = true
    
    @State private var score = 0
    
    @State private var roundCount = 1
    @State private var showingEndGameAlert = false
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Score: \(score)")
            Text("App chose: \(possibleMoves[appsChoice])")
            if playerShouldWin {
                Text("Win the round")
            }
            else {
                Text("Lose the round")
            }
            
            HStack {
                ForEach(0..<3) { number in
                    Button(possibleMoves[number]) {
                        buttonClicked(number)
                    }
                    .fontWeight(.bold)
                    .font(.system(size: 19))
                    .frame(width: 100, height: 50)
                    .padding(6)
                    .background(.cyan)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                }
            }
        }
        .alert("Score", isPresented: $showingEndGameAlert) {
            Button("New game", action: reset)
        } message: {
            VStack{
                Text("You score is: \(score)")
                Text("Do you want to start a new game?")
            }
        }
    }
    
    func reset() {
        score = 0
        roundCount = 0
        nextTurn()
    }
    
    func buttonClicked(_ number: Int) {
        let move = possibleMoves[number]
        
        if playerShouldWin {
            if winningMoves[appsChoice] == move {
                score += 1
            }
            else {
                score -= 1
            }
        }
        else {
            if losingMoves[appsChoice] == move {
                score += 1
            }
            else {
                score -= 1
            }
        }
        
        if roundCount == 10 {
            showingEndGameAlert = true
        }
        else {
            nextTurn()
        }
    }
    
    func nextTurn() {
        roundCount += 1
        
        appsChoice = Int.random(in: 0..<3)
        playerShouldWin.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
