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
    @State var isEditing: Bool = false
    @available(iOS 15.0, *)
    var body: some View {
        VStack {
            VStack{
                Text("Continue with Phone").font(.title2).fontWeight(.bold).foregroundColor(.black).padding()
                
                Text("You'll receive a 4 digit code\n to verify next.").font(.title2).foregroundColor(.gray).multilineTextAlignment(.center).padding()
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Enter your phone number").font(.caption).foregroundColor(.gray)
                        
                        iPhoneNumberField("(000) 000-0000", text: $phoneAuthData.phoneNumber)
                                    .font(UIFont(size: 30, weight: .light, design: .monospaced))
                                    .maximumDigits(10)
                                    .foregroundColor(Color.pink)
                                    .clearButtonMode(.whileEditing)
                                    .accentColor(Color.orange)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(color:.gray, radius: 10)
                                    .padding().keyboardType(.numberPad)
                        
                        Spacer(minLength: 0)
                        
                        Button {
                            Task{await phoneAuthData.sendOTP()}
                        } label: {
//                            NavigationLink(destination: PhoneVerification(phoneAuthData: phoneAuthData)) {
                            Text("Continue").foregroundColor(.black).padding(.vertical, 18).padding(.horizontal, 38).background(Color("black")).cornerRadius(15)
                            //}
                        }
                       
                    }.padding().background(Color.white)
                }

            }.frame(height: UIScreen.main.bounds.height/1.8).background(Color.white).cornerRadius(20)
            
            Spacer()
            
        }.background(Color("bg").ignoresSafeArea(.all, edges: .bottom)).navigationTitle("Login").padding().frame(maxHeight: .infinity, alignment: .top).background{
            NavigationLink(tag: "PHONE_VERIFICATION", selection: $phoneAuthData.navigationTag) {
                PhoneVerification().environmentObject(phoneAuthData)
            } label: {} .labelsHidden()
        }
    
        }
    }


@available(iOS 15.0, *)
struct PhoneAuthentication_Previews: PreviewProvider {
    static var previews: some View {
        PhoneAuthentication()
    }
}
