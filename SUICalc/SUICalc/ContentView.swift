//
//  ContentView.swift
//  SUICalc
//
//  Created by Coskun Caner on 5.01.2020.
//  Copyright © 2020 Coskun Caner. All rights reserved.
//

import SwiftUI

enum CalcButton:String {
    case zero, one, two, three, four, five, six, seven, eight, nine
    case equals, plus, minus, multiply, divide
    case ac, plusMinus, percent, dot
    
    var title:String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "5"
        case .eight: return "8"
        case .nine: return "9"
            
        case .equals: return "="
        case .plus: return "+"
        case .minus: return "−"
        case .multiply: return "×"
        case .divide: return "÷"
            
        case .ac: return "AC" //"℀"
        case .plusMinus: return "±"
        case .percent: return "%"
        case .dot: return "."
        default: return ""
        }
    }
    
    var bgColor:Color {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .dot:
            return Color(.darkGray)
        case .ac, .plusMinus, .percent:
            return Color(.lightGray)
        default:
            return .orange
        }
    }
}

//Env Object
//You can threat this as the global application state,
class GlobalEnvironment: ObservableObject {
    @Published var display = "4"
    
    func receiveInput(_ calcButton: CalcButton) {
        self.display = calcButton.title
    }
}



struct ContentView: View {
    
    @EnvironmentObject var env: GlobalEnvironment
    
    /*
     ["7", "8", "9", "X"],
     ["4", "5", "6", "-"],
     ["1", "2", "3", "+"],
     ["0", ".", ".", "="]
     */
    let buttons:[[CalcButton]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .dot, .equals]
    ]
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 12) {
                
                HStack {
                    Spacer()
                    Text(env.display).foregroundColor(.white)
                        .font(.system(size: 64))
                }.padding()
                
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { button in
                            
                            CalcButtonView(button: button)
                            
                        }
                    }
                }
            }.padding(.bottom)
        }
        
    }
    
}





struct CalcButtonView: View {
    
    var button: CalcButton
    @EnvironmentObject var env: GlobalEnvironment
    
    var body: some View {
        Button(action: {
            //action
            self.env.receiveInput(self.button)
            
        }) {
            //btTitle
            Text(button.title)
            .font(.system(size: 32))
            .frame(width: self.buttonWidht(button), height: self.buttonHeight())
            .foregroundColor(.white)
            .background(button.bgColor)
            .cornerRadius(self.buttonHeight())
        }
    }
    
    private func buttonWidht(_ button:CalcButton? = nil) -> CGFloat {
        if let b = button, b == .zero {
            let standard = (UIScreen.main.bounds.width - 5 * 12) / 4
            return 2 * standard + 12
        }
        
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
    
    private func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalEnvironment())
    }
}
