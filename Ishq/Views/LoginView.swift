//
//  LoginView.swift
//  Ishq
//
//  Created by Sishir Mohan on 2/26/23.
//

import SwiftUI

@available(iOS 15.0, *)
struct LoginView: View {
    @State var accessToken: String = ""
    @State var error: String = ""
    var body: some View {
        ZStack {
            Color.ishqBackgroundColor.ignoresSafeArea()
 
        VStack {
        
            Image("ishq-text")
              .resizable()
              .frame(width: 150, height: 100)
            DottedLine().stroke(style: StrokeStyle(lineWidth: 1))
                .frame(width: 1, height: 250)
                .foregroundColor(Color.ishqTextColor)
            Text("A new, familiar way to find love.").bold().padding(.bottom, 100).font(.BaskervilleTitle2)
            Group {
                Text("By tapping 'Sign in with Apple' / 'Sign in with Phone Number', you agree to our [Terms of Service](https://www.findishq.com/terms-of-service). Learn how we process your data in our [Privacy Policy](https://www.findishq.com/privacy-policy) and [Acceptable Use Policy](https://www.findishq.com/acceptable-use-policy).").font(.system(size: 10)).frame(width: 300, alignment: .center).padding().multilineTextAlignment(.center)
                SignInWithAppleView(accessToken: $accessToken, error: $error)
                    .frame(width: 300, height: 50).cornerRadius(40)
    //            Text(self.accessToken)
    //            Text(self.error)
                
                    
                        Button {
                            
                        } label: {
                            
                            NavigationLink(destination: PhoneAuthentication()) {
                                Text("Sign in with Phone Number").font(.InterTitle3).bold()}
                        }.padding().frame(width: 300, height: 50, alignment: .top).background(Color.callToActionColor).foregroundColor(Color.black
                        ).cornerRadius(40)
                        
                    
            }
            
            
            
        }.frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
}

@available(iOS 15.0, *)
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
                    LoginView()
                    
                    LoginView()
                        .environment(\.colorScheme, .dark)
                }
    }
}


struct DottedLine: Shape {
        
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        return path
    }
}

func getFontNames() {
    for family in UIFont.familyNames.sorted() {
        let names = UIFont.fontNames(forFamilyName: family)
        print("Family: \(family) Font names: \(names)")
    }
}
