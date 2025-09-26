//
//  BaseView.swift
//  SlideSideMenu
//
//  Created by Ivan Voznyi on 9/25/25.
//

import SwiftUI

struct BaseView: View {
    let offsetSideMenu: CGFloat = 90
    @State var showMenu: Bool = false
    @State var currentTab = "Home"
    @State var offset: CGFloat = 0 // Offset of the main content
    @State var lastStoreOffset: CGFloat = 0 // Store offset for drag start
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        GeometryReader { geometry in
            let menuWidth = geometry.size.width
            
            NavigationStack {
                HStack(spacing: 0) {
                    SideMenu(showMenu: $showMenu)
                        .frame(width: menuWidth)
                        .offset(x: (offset + offsetSideMenu) - geometry.size.width / 2)
                    
                    VStack(spacing: 0) {
                        TabView(selection: $currentTab) {
                            HomeView(showMenu: $showMenu)
                                .navigationBarTitleDisplayMode(.inline)
                                .toolbar(.hidden)
                                .tag("Home")
                            Text("Search").tag("Search").toolbar(.hidden)
                            Text("Notifications").tag("Notifications").toolbar(.hidden)
                            Text("Messages").tag("Message").toolbar(.hidden)
                        }
                        
                        VStack(spacing: 0) {
                            Divider()
                            HStack(spacing: 0) {
                                TabButton(id: "Home", image: "house")
                                TabButton(id: "Search", image: "magnifyingglass")
                                TabButton(id: "Notifications", image: "bell")
                                TabButton(id: "Message", image: "message")
                            }
                            .padding([.top], 15)
                        }
                    }
                    .frame(width: geometry.size.width)
                    .overlay {
                        let opacity: CGFloat = 0.4
                        if showMenu {
                            Rectangle()
                                .fill(Color.primary.opacity(Double(offset / menuWidth) * opacity))
                                .ignoresSafeArea()
                                .onTapGesture {
                                    withAnimation {
                                        showMenu = false
                                    }
                                }
                        }
                    }
                    .offset(x: offset - geometry.size.width / 2)
                }
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            let translation = value.translation.width
                            var newOffset = lastStoreOffset + translation
                            
                            newOffset = min(max(0, newOffset), menuWidth - offsetSideMenu)
                            
                            self.offset = newOffset
                        }
                        .onEnded { value in
                            let threshold = 90.0
                            if value.translation.width > threshold && !showMenu {
                                    showMenu =  true
                                    lastStoreOffset = value.translation.width
                            } else if value.translation.width < -threshold && showMenu {
                                    showMenu =  false
                                    lastStoreOffset = .zero
                            } else {
                                withAnimation {
                                    showMenu =  false
                                    lastStoreOffset = .zero
                                    offset = .zero
                                }
                            }
                        }
                )
            }
            .animation(.easeIn, value: offset)
            .animation(.easeInOut, value: showMenu)
            .onChange(of: showMenu) { _, newValue in
                let targetOffset = newValue ? menuWidth - offsetSideMenu : 0
                withAnimation {
                    offset = targetOffset
                }
                lastStoreOffset = targetOffset
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden)
        }
    }
    
    @ViewBuilder
    func TabButton(id: String, image: String) -> some View {
        Button {
            withAnimation {
                currentTab = id
            }
        } label: {
            Image(systemName: image)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fill)
                .frame(width: 23, height: 22)
                .frame(maxWidth: .infinity)
        }
        .foregroundStyle(currentTab == id ? .primary : .secondary)
    }
}

#Preview {
    BaseView()
}
