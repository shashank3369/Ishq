//
//  ContentView.swift
//  Ishq
//
//  Created by Shashank Kothapalli on 11/13/22.
//

import SwiftUI
import iPhoneNumberField

@available(iOS 15.0, *)
struct PhoneAuthentication: View {
    @StateObject var phoneAuthData = SignInWithPhoneNumberCoordinator()
    @FocusState private var keyboardFocused: Bool
    @Environment(\.dismiss) private var dismiss
    
    @available(iOS 15.0, *)
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
                        Text("What's your phone number?").font(.BaskervilleTitle).foregroundColor(.ishqTextColor).padding()
                        Spacer()
                    }.padding()
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                
                                Text("+1").font(.InterTitle2)
                                    .padding()
                                
                                iPhoneNumberField("", text: $phoneAuthData.phoneNumber)
                                    .font(UIFont(name: "Inter-Regular", size: 20))
                                    .maximumDigits(10)
                                    .foregroundColor(Color.ishqTextColor)
                                    .clearButtonMode(.whileEditing)
                                    .accentColor(Color.callToActionColor)
                                    .padding()
                                    .background(Color.ishqBackgroundColor)
                                    .padding().focused($keyboardFocused).keyboardType(.numberPad).onAppear {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
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
                                    if phoneAuthData.isLoading {
                                        Circle()
                                                          .trim(from: 0, to: 0.4)
                                                          .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                                                          .foregroundColor(.callToActionColor)
                                                          .frame(width: 25, height: 25)
                                                          .rotationEffect(Angle(degrees: phoneAuthData.isLoading ? 0 : 360))
                                                          .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                                    } else {
                                        Button {
                                                        Task{await phoneAuthData.verifyOTP()}
                                                    } label: {
                                                        Image("chevron-right").padding(.horizontal, 20)
                                        
                                                            .padding(.vertical, 20).background(Color.callToActionColor).cornerRadius(40)
                                                    }.padding(.trailing, 15)
                                    }
                                }
                                
                                
                            
                            }
                        }.padding().background(Color.ishqBackgroundColor)
                    }
                    
                }.frame(height: UIScreen.main.bounds.height/1.8).background(Color.ishqBackgroundColor).cornerRadius(20)
                
                Spacer()
                
            }.background(Color.ishqBackgroundColor).navigationBarBackButtonHidden(true).navigationBarHidden(true).padding().frame(maxHeight: .infinity, alignment: .top).background{
                NavigationLink(tag: "PHONE_VERIFICATION", selection: $phoneAuthData.navigationTag) {
                    PhoneVerification().environmentObject(phoneAuthData)
                } label: {} .labelsHidden()
            }
            
        }
        
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

