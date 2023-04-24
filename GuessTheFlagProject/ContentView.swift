//
//  ContentView.swift
//  GuessTheFlagProject
//
//  Created by yulias on 07/03/2023.

import SwiftUI

struct ContentView: View {

    @State private var showingScore = false
    @State private var gameEnd = false
    
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var questions = 1
    
    @State private var selectedFlag = -1
    
    @State private var countries = allCountries.shuffled()
    static let allCountries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    
    @State private var correctAnswer = Int.random(in: 0...2)
   
    var body: some View {
        ZStack {
            RadialGradient(stops:[
                .init(color: Color(red: 0.5, green: 0.1, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.73, green: 0.5, blue: 0.76), location: 0.3)
            ], center: .top, startRadius: 550, endRadius: 900)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                  
                VStack(spacing: 15){
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            //to be tapped
                                flagTapped(number)
                            } label: {
            FlagImage(name: countries[number])
                .rotation3DEffect(.degrees(selectedFlag == number ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                .opacity(selectedFlag == -1 || selectedFlag == number ? 1 : 0.25 )
                .saturation(selectedFlag == -1 || selectedFlag == number ? 1 : 0.6)
                .animation(.default, value: selectedFlag)
                        }
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
                
                Text("Question: \(questions)")
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score) ")
        }
        
        .alert("Game over!", isPresented: $gameEnd) {
            Button("Resume", action: resume)
        } message: {
            Text("Your final score was \(score) ")
        }
        }
        
        func flagTapped(_ number: Int) {
            selectedFlag = number
            
            if number == correctAnswer {
                scoreTitle = "Correct"
                score += 1
            } else {
                let needsThe = ["UK", "US"]
                let theirAnswer = countries[number]
                if needsThe.contains(theirAnswer) {
                    scoreTitle = "Wrong! That's the flag of the \(theirAnswer)."
                } else {
                    scoreTitle = "Wrong! That's the flag of \(theirAnswer)."
                }
                
                if score > 0 {
                    score -= 1
                }
            }
            if questions == 8 {
                gameEnd = true
            } else {
                showingScore = true
            }
            }

        func askQuestion() {
            countries.remove(at: correctAnswer)
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            questions += 1
            selectedFlag = -1
        }
    
    func resume() {
        questions = 0
        score = 0
        countries = Self.allCountries
        askQuestion()
    }
    }
    

    
    

    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
