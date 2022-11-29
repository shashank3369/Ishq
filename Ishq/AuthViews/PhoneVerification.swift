//
//  PhoneVerification.swift
//  Ishq
//
//  Created by Sishir Mohan on 11/24/22.
//

import SwiftUI

@available(iOS 15.0, *)
struct PhoneVerification: View {
    @EnvironmentObject var phoneAuthData: SignInWithPhoneNumberCoordinator
    @Environment(\.presentationMode) var present
    //MARK: TextField FocusState
    @FocusState var activeField: OTPField?
    var body: some View {
        VStack{
            OTPField()
            
            Button {
                Task{await phoneAuthData.verifyOTP()}
            } label: {
                Text("Verify").fontWeight(.semibold).foregroundColor(.white).padding(.vertical, 12).frame(maxWidth: .infinity).background{RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.blue)}
                    .padding().disabled(checkStates()).opacity(checkStates() ? 0.4 : 1)
            }.padding(.vertical)
            
            HStack(spacing: 12){
                Text("Didn't get a code?").font(.caption).foregroundColor(.gray)
                
                Button("Resend"){}.font(.callout)
            }.frame(maxWidth: .infinity, alignment: .leading)
        }.padding().frame(maxHeight: .infinity, alignment: .center).navigationTitle("Verification").onChange(of: phoneAuthData.otpFields) { newValue in OTPCondition(value: newValue)
            
        }.alert(phoneAuthData.errorMsg, isPresented: $phoneAuthData.showAlert) {
            
        }

    }
    
    func checkStates()->Bool{
        for index in 0..<6{
            if phoneAuthData.otpFields[index].isEmpty{return true}
        }
        return false
    }
    
    func OTPCondition(value: [String]) {
        
        //Checking if OTP is Pressed
        for index in 0..<6{
            if value[index].count == 6{
                DispatchQueue.main.async {
                    phoneAuthData.otpText = value[index]
                    phoneAuthData.otpFields[index] = ""
                    
                    //Updating All text fields with value
                    for item in phoneAuthData.otpText.enumerated(){
                        phoneAuthData.otpFields[item.offset] = String(item.element)
                    }
                }
                return
            }
        }
        
        //Moving Next Field If Current Field Type
        for index in 0..<5{
            if value[index].count == 1 && activeStateForIndex(index: index) == activeField{
                activeField = activeStateForIndex(index: index + 1)
            }
        }
        
        // Moving Back if current is empty and previous is not empty
        for index in 1...5{
            if value[index].isEmpty && !value[index-1].isEmpty{
                activeField = activeStateForIndex(index: index - 1)
            }
        }
        for index in 0..<6{
            if(value[index].count > 1) {
                phoneAuthData.otpFields[index] = String(value[index].last!)
            }
        }
    }
    
    //getting Code at Each index...
    func getCodeAtIndex(index: Int)->String{
        if phoneAuthData.code.count > index{
            let start = phoneAuthData.code.startIndex
            let current = phoneAuthData.code.index(start, offsetBy: index)
            return String(phoneAuthData.code[current])
        }
        
        return ""
    }
    
    @ViewBuilder
    func OTPField()->some View{
        HStack(spacing: 14) {
            ForEach(0..<6, id: \.self){index in
                VStack(spacing: 8){
                    TextField("", text: $phoneAuthData.otpFields[index]).keyboardType(.numberPad).textContentType(.oneTimeCode).multilineTextAlignment(.center).focused($activeField, equals: activeStateForIndex(index: index))
                    
                    Rectangle().fill(activeField == activeStateForIndex(index: index) ? .blue : .gray.opacity(0.3)).frame(height: 4)
                }.frame(width: 40)
            }
        }
        
    }
    
    func activeStateForIndex(index: Int)->OTPField{
        switch index{
        case 0: return .field1
        case 1: return .field2
        case 2: return .field3
        case 3: return .field4
        case 4: return .field5
        default: return .field6
        }
    }
    }


@available(iOS 15.0, *)
struct PhoneVerification_Previews: PreviewProvider {
    static var previews: some View {
        PhoneVerification().environmentObject(SignInWithPhoneNumberCoordinator())
    }
}

enum OTPField{
    case field1
    case field2
    case field3
    case field4
    case field5
    case field6
}


struct CodeView: View {
    var code: String
    var body: some View{
        VStack(spacing: 10) {
            Text(code).foregroundColor(.black).fontWeight(.bold).font(.title2).frame(height: 45).keyboardType(.numberPad)
            
            Capsule().fill(Color.gray.opacity(0.5)).frame( height: 4)
        }
    }
}
