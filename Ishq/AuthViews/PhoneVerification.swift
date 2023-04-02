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
    @Environment(\.dismiss) private var dismiss

    //MARK: TextField FocusState
    @FocusState var activeField: OTPField?
    @FocusState private var keyboardFocused: Bool
    var body: some View {
        ZStack {
            Color.ishqBackgroundColor.ignoresSafeArea()
            VStack {
                VStack{
                    HStack {
                        Spacer()
                        
                        Button {
                            dismiss()
                        } label: {
                            Image("close").padding(.horizontal, 5)
                                .padding(.vertical, 5).background(Color.ishqBackgroundColor)
                        }.padding(.trailing, 0)
                    }
                    HStack {
                        Text("Enter your verification code.").font(.BaskervilleTitle).foregroundColor(.ishqTextColor).padding()
                        Spacer()
                    }.padding()
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            OTPField().focused($keyboardFocused).keyboardType(.numberPad).onAppear {
                                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                                    keyboardFocused = true
                                                                }
                                                            }
                            

                            HStack {
                                Text("Ishq will send you a text with a verification code. Message and data rates may apply.").font(.InterBody).fixedSize(horizontal: false, vertical: true).foregroundColor(Color.gray).padding()
                            }
                           
                            
                            HStack {
                                Spacer()
                                
                                Button {
                                                        Task{await phoneAuthData.verifyOTP()}
                                                    } label: {
                                                        Image("chevron-right").padding(.horizontal, 20)
                                        
                                                            .padding(.vertical, 20).background(Color.callToActionColor).cornerRadius(40)
                                                    }.padding(.trailing, 15)
                            }
                        }.padding().background(Color.ishqBackgroundColor)
                    }
                    
                }.frame(height: UIScreen.main.bounds.height/1.8).background(Color.ishqBackgroundColor).cornerRadius(20)
                
                Spacer()
                
            }.background(Color.ishqBackgroundColor).frame(maxHeight: .infinity, alignment: .top).navigationBarBackButtonHidden(true).navigationBarHidden(true).padding().navigationTitle("Verification").onChange(of: phoneAuthData.otpFields) { newValue in OTPCondition(value: newValue)
                
            }.alert(phoneAuthData.errorMsg, isPresented: $phoneAuthData.showAlert) {

            
            }
            
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
            Spacer()
            ForEach(0..<6, id: \.self){index in
                VStack(spacing: 40){
                    TextField("", text: $phoneAuthData.otpFields[index]).keyboardType(.numberPad).textContentType(.oneTimeCode).multilineTextAlignment(.center).focused($activeField, equals: activeStateForIndex(index: index)).font(.InterTitle2).foregroundColor(.ishqTextColor)
                    
                    Rectangle().fill(Color.ishqTextColor).frame(height: 2)
                }
            }
            Spacer()
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
        Group {
            
            PhoneVerification().environmentObject(SignInWithPhoneNumberCoordinator())
            
            PhoneVerification().environmentObject(SignInWithPhoneNumberCoordinator()).environment(\.colorScheme, .dark)
        }
        
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


