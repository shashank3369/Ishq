//
//  ContentView.swift
//  Ishq
//
//  Created by Shashank Kothapalli on 11/13/22.
//

import SwiftUI
import iPhoneNumberField
import Supabase

@available(iOS 15.0, *)
struct PhoneAuthentication: View {
    @StateObject private var phoneAuthViewModel = PhoneAuthViewModel()
    @FocusState private var keyboardFocused: Bool
    @Environment(\.presentationMode) private var presentationMode
    
    @available(iOS 15.0, *)
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
                    HStack {
                        Text("What's your phone number?").font(.BaskervilleTitle).foregroundColor(.ishqTextColor).padding()
                        Spacer()
                    }.padding()
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                
                                Text("+1").font(.InterTitle2)
                                    .padding()
                                
                                TextField("", text: $phoneAuthViewModel.phoneNumber)
                                    .font(.InterTitle2)
                                    .onChange(of: phoneAuthViewModel.phoneNumber) { newValue in
                                            if !newValue.isEmpty {
                                                phoneAuthViewModel.phoneNumber = newValue.formatPhoneNumber() // Assuming formatPhoneNumber() is a method that exists and does what you intend
                                            }
                                        }
                                    .foregroundColor(Color.ishqTextColor)
                                    .accentColor(Color.callToActionColor)
                                    .padding()
                                    .background(Color.ishqBackgroundColor).overlay(
                                        RoundedRectangle(cornerRadius: 10) // Overlay a RoundedRectangle to act as the border
                                            .stroke(Color.ishqTextColor, lineWidth: 0.2) // Set the color and line width of the border
                                    )
                                    .padding().focused($keyboardFocused).keyboardType(.numberPad).onAppear {
                                        DispatchQueue.main.async {
                                            keyboardFocused = true
                                        }
                                    }
                            }
                            HStack {
                                Text("Ishq will send you a text with a verification code. Message and data rates may apply.").font(.InterBody).fixedSize(horizontal: false, vertical: true).foregroundColor(Color.gray).padding()
                            }
                            
                            
                            HStack {
                                Spacer()
                                Group {
                                    if phoneAuthViewModel.isLoading {
                                        Circle()
                                                          .trim(from: 0, to: 0.4)
                                                          .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                                                          .foregroundColor(.callToActionColor)
                                                          .frame(width: 25, height: 25)
                                                          .rotationEffect(Angle(degrees: phoneAuthViewModel.isLoading ? 0 : 360))
                                                          .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                                    } else {
                                        Button {
                                            Task{await phoneAuthViewModel.sendOTP()}
                                                    } label: {
                                                        Image("chevron-right").padding(.horizontal, 20)
                                        
                                                            .padding(.vertical, 20).background(Color.callToActionColor).cornerRadius(40)
                                                    }.padding(.trailing, 15).alert(isPresented: $phoneAuthViewModel.showAlert) {
                                                        Alert(title: Text("Error"), message: Text(phoneAuthViewModel.errorMsg), dismissButton: .default(Text("OK")))
                                                    }
                                    }
                                }
                                
                                
                            
                            }
                        }.padding().background(Color.ishqBackgroundColor)
                    }
                    
                }.frame(height: UIScreen.main.bounds.height/1.8).background(Color.ishqBackgroundColor).cornerRadius(20)
                
                Spacer()
                
            }.background(Color.ishqBackgroundColor).navigationBarBackButtonHidden(true).navigationBarHidden(true).padding().frame(maxHeight: .infinity, alignment: .top).background{
                NavigationLink(tag: "PHONE_VERIFICATION", selection: $phoneAuthViewModel.navigationTag) {
                    PhoneVerification().environmentObject(phoneAuthViewModel)
                } label: {} .labelsHidden()
            }
            
        }
        
    }

}

extension String {
    func formatPhoneNumber() -> String {
        let cleanNumber = components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        let mask = "(XXX) XXX-XXXX"
        
        var result = ""
        var startIndex = cleanNumber.startIndex
        var endIndex = cleanNumber.endIndex
        
        for char in mask where startIndex < endIndex {
            if char == "X" {
                result.append(cleanNumber[startIndex])
                startIndex = cleanNumber.index(after: startIndex)
            } else {
                result.append(char)
            }
        }
        
        return result
    }
}





@available(iOS 15.0, *)
struct PhoneAuthentication_Previews: PreviewProvider {
    static var previews: some View {
        Group {
                    PhoneAuthentication()
                    
                    PhoneAuthentication()
                        .environment(\.colorScheme, .dark)
                }
    }
}

