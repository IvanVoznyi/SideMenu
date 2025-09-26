//
//  SideBarMenu.swift
//  SlideSideMenu
//
//  Created by Ivan Voznyi on 9/24/25.
//

import SwiftUI

struct SideMenu_ZStack: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            SideMenuButton(title: "Home", icon: "house") {
                
            }

            SideMenuButton(title: "Basket", icon: "cart") {
                
            }

            SideMenuButton(title: "Favorite", icon: "star") {
                
            }

            SideMenuButton(title: "Delete", icon: "trash") {
                
            }
            Spacer()
            Toggle(isOn: $isDarkMode) {
                Text(isDarkMode ? "Light Mode" : "Dark Mode")
                    .bold()
                    .padding(.leading, 10)
            }
            .tint(.gray)
            .preferredColorScheme(isDarkMode ? .dark : .light)
            Spacer()
        }
        .frame(width: 200)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct SideMenuButton: View {
    var title: String
    var icon: String
    var action: () -> Void

    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(systemName: icon)
                Text(title)
                    .font(.system(size: 16))
            }
            .font(.system(size: 16))
            .padding(.leading)
            .frame(width: 200, height: 50, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 0.9)
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
            )
        }
        .foregroundStyle(.primary)
        .padding(.leading, 30)
    }
}

#Preview {
    SideMenu_ZStack()
}
