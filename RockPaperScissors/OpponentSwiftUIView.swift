//
//  OpponentSwiftUIView.swift
//  RockPaperScissors
//
//  Created by Балауса Косжанова on 13.04.2023.
//

import SwiftUI

struct OpponentSwiftUIView: View {
    var body: some View {
        VStack() {
            CustomTitleText(text: "Your opponent’s pick")
                .padding(.bottom,130)
            Button {
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 48)
                        .foregroundColor(Color(red: 0.953, green: 0.949, blue: 0.973))
                   
                    Image(systemName: "slowmo")
                        .font(.system(size: 40))
                        
                        .foregroundColor(.black)
                       
                }
                
               
            }.frame(width: 342,height: 128)
        }
    }
}

struct OpponentSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        OpponentSwiftUIView()
    }
}
