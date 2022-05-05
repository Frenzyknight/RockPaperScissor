//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Gaurav Ganju on 16/02/22.
//

import SwiftUI

struct ContentView: View {
    let choiceOfMove = ["🪨", "📄", "✂️"].shuffled()
    let winConditions = ["🪨":"📄",
                         "📄":"✂️",
                         "✂️":"🪨"]
    @State var computerChoice = Int.random(in: 0...2)
    @State var randomChoice = Bool.random()
    @State var gameScore = 0
    @State var buttonPress = false
   
    var getResult: String {
        if randomChoice {
            return "Win"
        } else {
            return "Lose"
        }
    }
    
    var getFontColor: Color {
        if randomChoice {
            return .green
        } else {
            return .red
        }
    }
    
    func addScore () {
        gameScore += 1
        computerChoice = Int.random(in: 0...2)
        randomChoice = Bool.random()
    }
    
    func resetGame () {
        computerChoice = Int.random(in: 0...2)
        randomChoice = Bool.random()
        gameScore = 0
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("Rose"), Color("Water")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Text("Pick a move")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                Spacer()
                
                VStack(spacing: 15) {
                    Text("You have to")
                        .font(.title)
                    
                    Text("\(getResult)")
                        .font(.largeTitle)
                        .foregroundColor(getFontColor)
                        .padding(10)

                    Text("Computer's Choice is ")
                        .font(.title)
                    
                    Text("\(choiceOfMove[computerChoice])")
                        .font(.system(size: 70))
                        .padding(10)
                    
                }
                .frame(maxWidth:.infinity)
                .padding(.vertical,20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                
                HStack {
                    ForEach(choiceOfMove, id:\.self) { choice in
                        Button {
                            if gameScore == 7 {
                                buttonPress.toggle()
                            }
                            else if choice == winConditions[choiceOfMove[computerChoice]] && randomChoice == true  {
                                addScore()
                            }
                            else if choice != winConditions[choiceOfMove[computerChoice]] && randomChoice == false {
                                addScore()
                            } else {
                                randomChoice = Bool.random()
                                gameScore -= 1
                                
                            }
                        } label: {
                            Spacer()
                            Text("\(choice)")
                                .font(.system( size: 70))
                                .padding()
                                .background(.thinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                            Spacer()
                        }
                    }
                }
                Spacer()
                Text("Score: \(gameScore)")
                    .padding()
                    .font(.largeTitle)
            }
            .padding()
        }
        .alert("Congratulations", isPresented: $buttonPress) {
            Button("Reset Game", role: .destructive , action: resetGame)
        } message: {
            Text("Click below to start again !")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.light
        )
    }
}
