//
//  WelcomePageSwiftUi.swift
//  RockPaperScissors
//
//  Created by Балауса Косжанова on 13.04.2023.
//

import SwiftUI

struct WelcomePageSwiftUi: View {
    var body: some View {
        WelcomePage()
    }
}
struct WelcomePage: View {
    @State private var showSinglePageGame = false
    @State private var showMultiPageGame = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("back")
                    .resizable()
                    .ignoresSafeArea()
                VStack {
                    Text("Welcome to the game!")
                        .font(.system(size: 54))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.top,92)
                    Spacer()
                    
                    Button(action:{showSinglePageGame = true})
                    {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(Color(red: 0.404, green: 0.314, blue: 0.643))
                            Text("Single player")
                                .foregroundColor(.white)
                        }
                        .frame(width: 358,height: 50)
                    }
                    NavigationLink("", destination: SinglePlayerSwiftUIView(), isActive: $showSinglePageGame)
                    Button(action:{showMultiPageGame = true})
                    {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(Color(red: 0.404, green: 0.314, blue: 0.643))
                            Text("Multi player")
                                .foregroundColor(.white)
                        }
                        .frame(width: 358,height: 50)
                    }
                  
                    NavigationLink("", destination: MultiPlayerSwiftUIView(), isActive: $showMultiPageGame)
                    
                }
            }
        }
    }
    
}
//struct CustomButtom: View {
//    var label: String
//    var body: some View {
//        Button{
//            
//        } label: {
//            ZStack {
//                RoundedRectangle(cornerRadius: 8)
//                    .foregroundColor(Color(red: 0.404, green: 0.314, blue: 0.643))
//                Text(label)
//                    .foregroundColor(.white)
//            }
//            .frame(width: 358,height: 50)
//        }
//      
//    }
//}

struct WelcomePageSwiftUi_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePageSwiftUi()
    }
}
