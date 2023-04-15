//
//  HomeScreen.swift
//  Ishq
//
//  Created by Sishir Mohan on 12/2/22.
//

import SwiftUI
import RealmSwift

struct HomeScreen: View {
    @StateObject var phoneAuthData = SignInWithPhoneNumberCoordinator()
    @StateObject private var vm = UserViewModel()
    
    var body: some View {
        
        VStack {
            Button {
                Task{phoneAuthData.logOut()}
            } label: {
                Text("Log Out").foregroundColor(.black).padding(.vertical, 18).padding(.horizontal, 38).background(Color.white).cornerRadius(15)
                //}
            }
        }.onAppear(perform: vm.fetchUserDetails)
        
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
