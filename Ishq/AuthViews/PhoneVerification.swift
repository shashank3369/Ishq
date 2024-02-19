//
//  PhoneVerification.swift
//  Ishq
//
//  Created by Sishir Mohan on 11/24/22.
//

import SwiftUI

@available(iOS 15.0, *)
struct PhoneVerification: View {
    @EnvironmentObject var phoneAuthViewModel: PhoneAuthViewModel
    @FocusState private var focusedField: Int?
    @Environment(\.presentationMode) private var presentationMode
    

    //MARK: TextField FocusState
    //@FocusState var activeField: OTPField?
    @FocusState private var keyboardFocused: Bool
    var body: some View {
        ZStack {
            Color.ishqBackgroundColor.ignoresSafeArea()
            VStack {
                VStack{
                    HStack {
                        
                        
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image("chevron-left").padding(.horizontal, 5)
                                .padding(.vertical, 5).background(Color.ishqBackgroundColor)
                        }.padding(.leading, 0)
                        Spacer()
                    }
                    VStack(spacing: -20) {
                        HStack {
                            Text("Enter your verification code.").font(.BaskervilleTitle).foregroundColor(.ishqTextColor).padding()
                            Spacer()
                        }.padding()
                        HStack {
                            Text("We just sent a code to +1  \(phoneAuthViewModel.phoneNumber)").font(.PoppinsBody).foregroundColor(.ishqTextColor)
                        }
                    }
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            
                            HStack {
                                TextField("", text: $phoneAuthViewModel.otpToken)
                                    .font(.InterTitle2)
                                    .foregroundColor(Color.ishqTextColor)
                                    .accentColor(Color.callToActionColor)
                                    .padding()
                                    .overlay(
                                                    RoundedRectangle(cornerRadius: 10) // Overlay a RoundedRectangle to act as the border
                                                        .stroke(Color.ishqTextColor, lineWidth: 0.2) // Set the color and line width of the border
                                                )
                                    .background(Color.ishqBackgroundColor)
                                    .padding().focused($keyboardFocused).keyboardType(.numberPad).onAppear {
                                        DispatchQueue.main.async {
                                            keyboardFocused = true
                                        }
                                    }
                            }

                            HStack {
                                Spacer()
                                
                                Button {
                                    Task{
                                        do {
                                            let appUser = try await phoneAuthViewModel.verifyOTP()
                                        } catch {
                                            print("Issue with OTP")
                                        }
                                    }
                                } label: {
                                    Image("chevron-right").padding(.horizontal, 20)
                                    
                                        .padding(.vertical, 20).background(Color.callToActionColor).cornerRadius(40)
                                }.padding(.trailing, 15)
                            }
                        }.padding().background(Color.ishqBackgroundColor)
                    }
                    
                    
                    
                    .padding()
//                    .onAppear {
//                        focusedField = 0 // Focus the first field when the view appears
                    
                
                    
                }.frame(height: UIScreen.main.bounds.height/1.8).background(Color.ishqBackgroundColor).cornerRadius(20)
                
                
            }.background(Color.ishqBackgroundColor).frame(maxHeight: .infinity, alignment: .top).navigationBarBackButtonHidden(true).navigationBarHidden(true).padding().navigationTitle("Verification")
                
            }.alert(phoneAuthViewModel.errorMsg, isPresented: $phoneAuthViewModel.showAlert) {

            
            }
            
        }
        
    }
    



@available(iOS 15.0, *)
struct PhoneVerification_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            
            PhoneVerification().environmentObject(PhoneAuthViewModel())
            
            PhoneVerification().environmentObject(PhoneAuthViewModel()).environment(\.colorScheme, .dark)
        }
        
    }
}


