//
//  SinglePlayerSwiftUIView.swift
//  RockPaperScissors
//
//  Created by Балауса Косжанова on 13.04.2023.
//

import SwiftUI



enum ScreenState {
    case choose
    case change
    case opponentChoose
    case showOpponent
    case playGame
    
   
}

enum Choices: String {
    case paper = "📃"
    case rock = "✂"
    case scissors = "🗿"
    case none = ""
    
    
   
}
func randomChoice() -> Choices {
    let array: [Choices] = [.paper, .scissors, .rock]
    return array.randomElement()!
}
class StartGame {
    var myScore: Int = 0
    var opponentScore: Int = 0

    func resultOfGame(o:Choices, m: Choices) -> String {
        switch (o, m) {
        case (.paper , .rock),(.rock,.scissors),(.scissors,.paper) :
            myScore += 1
            return "Win!"
        case (.rock , .paper), (.scissors,.rock),(.paper,.scissors):
            opponentScore += 1
            return "Lose!"
        default:
            return "Tie!"
        }
    }
}

struct SinglePlayerSwiftUIView: View {
    @State var screenState: ScreenState = .choose
    @State var selfChoice: Choices = .none
    @State var oponentChoice: Choices = .none
    var body: some View {
        switch screenState {
        case .choose:
           ChooseView(selfChoice: $selfChoice, screenState: $screenState)
        case .change:
            ChangeChoiceView(choice: $selfChoice, screenState: $screenState)
        case .opponentChoose:
            OpenentWaitView(oponentChoice: $oponentChoice, screenState: $screenState)
        case .showOpponent:
            OpenentChoiceView(oponentChoice: oponentChoice, screenState: $screenState)
        case .playGame:
            GameLogic(screenState: $screenState,oponentChoice: oponentChoice, myChoice: selfChoice)
            
        }

    }
}
struct GameLogic: View {
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

struct ChooseView: View {
    @Binding var selfChoice: Choices
    @Binding var screenState: ScreenState
    var body: some View {

            VStack {
                CustomTitleText(text:"Take your pick")
                Text("Score 0:0")
                    .foregroundColor(Color(red: 0.404, green: 0.314, blue: 0.643))
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
struct ChangeChoiceView: View {
    @Binding var choice: Choices
    @Binding var screenState: ScreenState
 
    var body: some View {
        VStack {
            CustomTitleText(text:"Your pick")
                .padding(.top,92)
            Text("Score 0:0")
                .foregroundColor(Color(red: 0.404, green: 0.314, blue: 0.643))
               .padding(.bottom,120)
                
            
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
struct CustomTitleText: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.system(size: 54))
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .padding(.bottom,12)
         
    }
}
struct ChoiceButtom: View {
    @State private var showWelcomeView = false
    var label: String
    var body: some View {
        NavigationView {
            Button(action: { showWelcomeView = true }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 48)
                        .foregroundColor(Color(red: 0.953, green: 0.949, blue: 0.973))
                    
                    Text(label)
                        .font(.system(size: 80))
                }
                
                
            }
            
           
        }.frame(width: 342,height: 128)
            .padding(.bottom,10)
    }
}
struct OpenentWaitView: View {
    @Binding var oponentChoice: Choices
    @Binding var screenState: ScreenState
    var body: some View {
        VStack() {
            CustomTitleText(text: "Your     opponent is thinking")
                .padding(.bottom,130)
            Button {
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 48)
                        .foregroundColor(Color(red: 0.953, green: 0.949, blue: 0.973))
                    
                    Image(systemName: "slowmo")
                        .font(.system(size: 40))
                        .foregroundColor(.black)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                oponentChoice = randomChoice()
                                screenState = .showOpponent
                            }
                        }
                    
                    
                }
                
                
            }.frame(width: 342,height: 128)
        }
    }
}

struct OpenentChoiceView: View {
    var oponentChoice: Choices
    @Binding var screenState: ScreenState
    var body: some View {
        VStack() {
            CustomTitleText(text: "Your opponent’s pick")
                .padding(.bottom,130)
            Button (action: { screenState = .playGame }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 48)
                        .foregroundColor(Color(red: 0.953, green: 0.949, blue: 0.973))
                    
                    Text(oponentChoice.rawValue)
                        .font(.system(size: 40))
                        .foregroundColor(.black)
                }
            }.frame(width: 342,height: 128)
        }
    }
}



struct SinglePlayerSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SinglePlayerSwiftUIView()
    }
}
