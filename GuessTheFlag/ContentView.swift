//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Nicholas Phoon on 5/6/26.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var showingFinalScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var questionNumber = 1
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "UK", "US"]
    @State var correctAnswer = Int.random(in: 0...2)
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Text("Guess the Flag")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(.white)
                Spacer()
                
                VStack {
                    
                   
                    Text("Tap the flag of")
                        .font(.subheadline.weight(.heavy))
                        .foregroundStyle(.white)
                        
                    Text(countries[correctAnswer])
                        .font(.largeTitle.weight(.semibold))
                        .foregroundStyle(.mint)
                    
                }
                
                
                ForEach(0..<3){
                    number in
                    Button {
                        // flag was tapped
                        flagTapped(number)
                       
                    }
                    label: {
                        Image(countries[number])
                            .shadow(radius: 5)
                        
                    }
                }
                Spacer()
                Text("Question \(questionNumber) / 8")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundStyle(.green)
                Spacer()
            }
            .padding()
            
            
        }
        .onAppear{
            countries.shuffle()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        
        .alert(scoreTitle, isPresented: $showingFinalScore){
            Button("Restart", action: restartGame)
            
        } message: {
            Text("Your final score is \(score) / 8")
        }
    }
    
    func restartGame(){
        score = 0
        questionNumber = 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func askQuestion(){
        questionNumber += 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "correct"
            score += 1
        }
        else{
            scoreTitle = "Wrong! Thats the flag of \(countries[number])"
        }
        if questionNumber == 8 {
//            scoreTitle = "End of Game!"
            showingFinalScore = true
        }
        else{
            
            showingScore = true
        }
        
       
        
        
    }
}

#Preview {
    ContentView()
}
