import SwiftUI

struct HomeScreen: View {
    
    @StateObject private var phoneAuthViewModel = PhoneAuthViewModel()
    var body: some View {
        VStack {
            Spacer()
            
            // Logo image
            Image("Frame 5") // Make sure to add this image to your Xcode project's assets
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            
            Text("A new, familiar way to find love.")
                .font(.title3)
                .padding(.bottom, 50)
            
            // Join now button
            Button(action: {
                // Handle the join now action
            }) {
                Text("Join now")
                    .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(25)
            }
            .padding(.horizontal, 50)
            
            // Login text
            HStack {
                Text("Already have account?")
                Button {
                    Task{
                        do {
                            try await phoneAuthViewModel.logOut()
                        } catch {
                            print("Issue with OTP")
                        }
                    }
                } label: {
                    Image("chevron-right").padding(.horizontal, 20)
                    
                        .padding(.vertical, 20).background(Color.callToActionColor).cornerRadius(40)
                }.padding(.trailing, 15)
            }
            .padding(.top, 15)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
