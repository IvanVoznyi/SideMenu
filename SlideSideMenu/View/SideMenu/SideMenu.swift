//
//  SideMenu.swift
//  SlideSideMenu
//
//  Created by Ivan Voznyi on 9/25/25.
//

import SwiftUI

struct SideMenu: View {
    @Binding var showMenu: Bool
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                VStack(alignment: .leading, spacing: 15) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 65, height: 65)
                        .clipShape(Circle())
                    Text("John Doe")
                        .font(.title2.bold())
                    Text("@johndoe")
                        .font(.callout)
                    
                    HStack(spacing: 20) {
                        Button{
                            
                        } label: {
                            Label {
                                Text("Followers")
                            } icon : {
                                Text("250")
                                    .fontWeight(.bold)
                            }
                        }
                        Button{
                            
                        } label: {
                            Label {
                                Text("Following")
                            } icon : {
                                Text("4.5M")
                                    .fontWeight(.bold)
                            }
                        }
                    }
                    .foregroundStyle(.primary)
                }
                .padding([.horizontal,.leading])
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        VStack(alignment: .leading, spacing: 45) {
                            TabButton(title: "Profile", image: "person.crop.circle")
                            TabButton(title: "Lists", image: "list.bullet.rectangle.portrait")
                            TabButton(title: "Topics", image: "captions.bubble")
                            TabButton(title: "Bookmarks", image: "bookmark")
                            TabButton(title: "Moments", image: "bolt")
                            TabButton(title: "Purchases", image: "cart")
                            TabButton(title: "Monetization", image: "banknote")
                        }
                        .padding(.leading)
                        .padding(.top, 35)
                        
                        Divider()
                        
                        TabButton(title: "Twitter Ads", image: "square.and.pencil")
                            .padding(.leading)
                            .padding([.top, .bottom], 25)
                        
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 30) {
                            Button("Settings and Privacy") {
                                
                            }
                            
                            Button("Help Center") {
                                
                            }
                        }
                        .padding(.leading)
                        .padding([.top, .bottom], 25)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.primary)
                    }
                }
                
                VStack(spacing: 0) {
                    Divider()
                    
                    HStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "lightbulb.max")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 22, height: 22)
                        }
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "qrcode")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 22, height: 22)
                        }
                    }
                    .padding(.horizontal, 35)
                    .padding(.top)
                    .foregroundStyle(.primary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(width: geometry.size.width - 90)
            .frame(maxHeight: .infinity)
            .background(
                Color.primary
                    .opacity(0.04)
                    .ignoresSafeArea()
            )
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    @ViewBuilder
    func TabButton(title: String, image: String) -> some View {
        NavigationLink {
            Text("\(title) View")
                .navigationTitle(Text("\(title) View"))
        } label: {
            HStack(spacing: 14) {
                Image(systemName: image)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 22, height: 22)
                
                Text(title)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundStyle(.primary)
    }
}

#Preview {
    SideMenu(showMenu: .constant(false))
}
