//
//  ChooseUserTypeScreen.swift
//  Ishq
//
//  Created by Sishir Mohan on 4/24/23.
//

import SwiftUI

struct ChooseUserTypeScreen: View {
   
    @State private var selection = 0
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.ishqBackgroundColor.ignoresSafeArea()
                
                VStack {
                    HStack {
                        Spacer()
                        
                        Button {
                        } label: {
                            Text("Log Out")
                        }.padding(.trailing, 0)
                    }
                    .padding()
                    HStack{
                        VStack{
                            Text("Welcome to Ishq! Tell us why you're here.")
                                .font(.BaskervilleTitle2)
                                .padding()
                        }
                        
                        Spacer()
                    }.padding()
                    
                    
                    Picker(selection: $selection, label: Text("").font(.BaskervilleTitle)) {
                        Text("Date and find my match").font(.BaskervilleTitle).tag(0)
                        Text("Play matchmaker").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    if selection == 0 {
                        GridStack(rows: 2, columns: 2, rowSpacing: 60, columnSpacing: 50) { row, col in
                                           VStack {
                                               switch (row, col) {
                                               case (0, 0):
                                                   ImageView(imageName: "three-profiles")
                                                   Text("View three profiles each day").font(.InterBody)
                                               case (0, 1):
                                                   ImageView(imageName: "match-and-chat")
                                                   Text("Chat with one person at a time").font(.InterBody)
                                               case (1, 0):
                                                   ImageView(imageName: "invite-friends")
                                                   Text("Invite your friends to be matchmakers").font(.InterBody)
                                               case (1, 1):
                                                   ImageView(imageName: "send-profiles")
                                                   Text("Receive profiles from people you trust").font(.InterBody)
                                               default:
                                                   EmptyView()
                                               }
                                           }
                                       }
                                       .padding(.horizontal, 10)
                                       .padding(.vertical)
                    } else if selection == 1 {
                        GridStack(rows: 2, columns: 2, rowSpacing: 60, columnSpacing: 50) { row, col in
                                           VStack {
                                               switch (row, col) {
                                               case (0, 0):
                                                   ImageView(imageName: "three-profiles")
                                                   Text("View three profiles each day").font(.InterBody)
                                               case (0, 1):
                                                   ImageView(imageName: "invite-friends")
                                                   Text("Invite singles to join the app").font(.InterBody)
                                               case (1, 0):
                                                   ImageView(imageName: "send-profiles")
                                                   Text("Send profiles to your friends").font(.InterBody)
                                               case (1, 1):
                                                   ImageView(imageName: "save-profiles")
                                                   Text("Save profiles to keep track").font(.InterBody)
                                               default:
                                                   EmptyView()
                                               }
                                           }
                                       }
                                       .padding(.horizontal, 10)
                                       .padding(.vertical)
                    }
   
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            
                        } label: {
                            Image("chevron-right").padding(.horizontal, 20)
                            
                                .padding(.vertical, 20).background(Color.callToActionColor).cornerRadius(40)
                        }.padding(.trailing, 15)
                    }
                }.background(Color.ishqBackgroundColor).frame(maxHeight: .infinity, alignment: .top).navigationBarBackButtonHidden(true).navigationBarHidden(true).padding().navigationTitle("Choose User Type")
            }
        }
    }
}

struct ChooseUserTypeScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChooseUserTypeScreen()
            ChooseUserTypeScreen()
                .environment(\.colorScheme, .dark)
        }
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let rowSpacing: CGFloat   // Added rowSpacing property
    let columnSpacing: CGFloat   // Added columnSpacing property
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack(spacing: rowSpacing) {   // Apply rowSpacing to VStack
            ForEach(0 ..< rows, id: \.self) { row in
                HStack(spacing: columnSpacing) {   // Apply columnSpacing to HStack
                    ForEach(0 ..< columns, id: \.self) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
}

struct ImageView: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}
