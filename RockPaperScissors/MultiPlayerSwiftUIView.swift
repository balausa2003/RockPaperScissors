//
//  MultiPlayerSwiftUIView.swift
//  RockPaperScissors
//
//  Created by Балауса Косжанова on 14.04.2023.
//

import SwiftUI

struct MultiPlayerSwiftUIView: View {
    @State var screenState: ScreenState = .choose
    @State var selfChoice: Choices = .none
    @State var oponentChoice: Choices = .none
    var body: some View {
        switch screenState {
        case .choose:
           ChooseViewPlayerOne(selfChoice: $selfChoice, screenState: $screenState)
        case .change:
            ChangeChoiceViewPlayerOne(choice: $selfChoice, screenState: $screenState)
        case .opponentChoose:
            OpponentWaitingView(screenState: $screenState)
        case .showOpponent:
            ChooseViewPlayerTwo(opponentChoose: $oponentChoice, screenState: $screenState)
        case .playGame:
            GameLogicMulti(screenState: $screenState,oponentChoice: oponentChoice, myChoice: selfChoice)
            
        }
    }
}
struct ChooseViewPlayerOne: View {
    @Binding var selfChoice: Choices
    @Binding var screenState: ScreenState
    var body: some View {

            VStack {
                CustomTitleText(text:"Take your pick")
            HStack {
                    Text("Player 1")
                    Text("•")
                    Text("Score 0:0")
                        
                }.foregroundColor(Color(red: 0.404, green: 0.314, blue: 0.643))
                    .padding(.bottom,74)
               
                    
                ChoiceButtom(label: "📃")
                    .onTapGesture {
                        selfChoice = .paper
                        screenState = .change
                    }
                ChoiceButtom(label: "✂")
                    .onTapGesture {
                        selfChoice = .rock
                        
                        screenState = .change
                    }
                ChoiceButtom(label: "🗿")
                    .onTapGesture {
                        selfChoice = .scissors
                        screenState = .change
                    }
            
         
            
            
        }
        
    }
}
struct ChangeChoiceViewPlayerOne: View {
    @Binding var choice: Choices
    @Binding var screenState: ScreenState
 
    var body: some View {
        VStack {
            CustomTitleText(text:"Your pick")
                .padding(.top,92)
            HStack {
                    Text("Player 1")
                    Text("•")
                    Text("Score 0:0")
                        
                }.foregroundColor(Color(red: 0.404, green: 0.314, blue: 0.643))
                    .padding(.bottom,74)
               
            
            Button {
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 48)
                        .foregroundColor(Color(red: 0.953, green: 0.949, blue: 0.973))
                   
                    Text(choice.rawValue)
                        .font(.system(size: 80))
                        .onTapGesture {
                            screenState = .opponentChoose
                        }
                        
                        .foregroundColor(.black)
                       
                }
                
                
            }.frame(width: 342,height: 128)
                
            Spacer()
            Button(action:{ screenState = .choose })
            {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(Color(red: 0.404, green: 0.314, blue: 0.643))
                    Text("I changed my mine")
                        .foregroundColor(.white)
                    
                }
                .frame(width: 358,height: 50)
                
            }
           

        }
        
    }
}
struct OpponentWaitingView: View {
    @Binding var screenState: ScreenState
    var body: some View {
        VStack {
            CustomTitleText(text: "Pass the phone to your opponent")
                .padding(.top,120)
            Spacer()
            Button(action:{ screenState = .showOpponent })
            {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(Color(red: 0.404, green: 0.314, blue: 0.643))
                    Text("Ready to continue")
                        
                        .foregroundColor(.white)
                    
                }
                .frame(width: 358,height: 50)
                
            }
        }
    }
}
struct ChooseViewPlayerTwo: View {
    @Binding var opponentChoose: Choices
    @Binding var screenState: ScreenState
    var body: some View {

            VStack {
                CustomTitleText(text:"Take your pick")
            HStack {
                    Text("Player 2")
                    Text("•")
                    Text("Score 0:0")
                        
                }.foregroundColor(Color(red: 0.404, green: 0.314, blue: 0.643))
                    .padding(.bottom,74)
               
                    
                ChoiceButtom(label: "📃")
                    .onTapGesture {
                        opponentChoose = .paper
                        screenState = .playGame
                    }
                ChoiceButtom(label: "✂")
                    .onTapGesture {
                        opponentChoose = .rock
                        
                        screenState = .playGame
                    }
                ChoiceButtom(label: "🗿")
                    .onTapGesture {
                        opponentChoose = .scissors
                        screenState = .playGame
                    }
            
         
            
            
        }
        
    }
}
struct GameLogicMulti: View {
    @Binding var screenState: ScreenState
    var oponentChoice: Choices
    var myChoice: Choices
    var body: some View {
        let result = StartGame()
        VStack {
         Spacer()
            LinearGradient(colors:[Color(red: 255/255, green: 204/255, blue: 0),Color(red: 255/255, green: 92/255, blue: 0)], startPoint: .bottomLeading, endPoint: .topTrailing)
                .frame(width: 220,height: 62)
                .mask {
                    CustomTitleText(text: result.resultOfGame(o: oponentChoice, m: myChoice))
                    
                }
            Text("Score \(result.myScore):\(result.opponentScore)")
                .foregroundColor(Color(red: 0.404, green: 0.314, blue: 0.643))
               .padding(.bottom,120)
          
            ZStack {
                Button(action: {}) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 48)
                            .foregroundColor(Color(red: 0.953, green: 0.949, blue: 0.973))
                        Text(myChoice.rawValue)
                            .font(.system(size: 80))
                    }
                    .frame(width: 198,height: 128)
                    .padding(.trailing,150)
                }
                Button(action: {}) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 48)
                            .foregroundColor(Color(red: 0.953, green: 0.949, blue: 0.973))
                        
                        Text(oponentChoice.rawValue)
                            .font(.system(size: 80))
                    }
                    .frame(width: 198,height: 128)
                    .offset(x:75, y: 72)
                }
             }
            Spacer()
            Button(action:{ screenState = .choose })
            {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(Color(red: 0.404, green: 0.314, blue: 0.643))
                    Text("Another Round")
                        .foregroundColor(.white)
                    
                }
                .frame(width: 358,height: 50)
            }
        }
    }
}

struct MultiPlayerSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MultiPlayerSwiftUIView()
    }
}
