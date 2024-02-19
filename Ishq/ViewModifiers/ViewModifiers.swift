//
//  ViewModifiers.swift
//  Ishq
//
//  Created by Sishir Mohan on 2/18/24.
//

import Foundation
import SwiftUI
import Combine

struct OtpModifier: ViewModifier {
    
    @Binding var pin : String
    
    var textLimit = 1

    func limitText(_ upper : Int) {
        if pin.count > upper {
            self.pin = String(pin.prefix(upper))
        }
    }
    
    
    //MARK -> BODY
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .onReceive(Just(pin)) {_ in limitText(textLimit)}
            .frame(width: 45, height: 45)
            .background(Color.white.cornerRadius(5))
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("blueColor"), lineWidth: 2)
            )
    }
}
