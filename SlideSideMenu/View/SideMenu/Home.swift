//
//  HomeV2.swift
//  SlideSideMenu
//
//  Created by Ivan Voznyi on 9/25/25.
//

import SwiftUI

struct HomeView: View {
    @Binding var showMenu: Bool
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                HStack {
                    Button {
                        withAnimation {
                            showMenu.toggle()
                        }
                    } label: {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 44, height: 44)

                    }
                    Spacer()
                    NavigationLink {
                        Text("Timeline View")
                            .navigationTitle(Text("Timeline View"))
                    } label: {
                        Image(systemName: "sparkles.2")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 44, height: 44)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 20)
                Divider()
            }
            .overlay {
                Image(systemName: "apple.meditate")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
            }
            Spacer()
        }
        .foregroundStyle(.primary)
    }
}

#Preview {
    HomeView(showMenu: .constant(false))
}
