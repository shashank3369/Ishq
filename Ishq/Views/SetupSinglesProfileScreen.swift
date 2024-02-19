import SwiftUI

struct SetupSinglesProfileScreen: View {
    @State private var text = ""
    @State private var isEditing = true

    var body: some View {
        ScrollView {
            ZStack(alignment: .top) {
                Color.black
                    .frame(height: 120)
                    .edgesIgnoringSafeArea(.top)

                Text("Let's set up your profile")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.top, 40)

            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct SetupSinglesProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        SetupSinglesProfileScreen()
    }
}
