//
//  HomeView.swift
//  SlideSideMenu
//
//  Created by Ivan Voznyi on 9/24/25.
//

import SwiftUI

struct HomeView_ZStack: View {
    @State private var dragging: CGSize = .zero
    @State private var position: CGSize = .zero
    @State var sideBarShow = false
    let sideMenuWidth: CGFloat = 230
    
    
    var body: some View {
        GeometryReader { geometry in
            let screenHeight: CGFloat = geometry.size.height
            ZStack {
                Group {
                    Color.gray.opacity(0.2).ignoresSafeArea()
                    Image(systemName: sideBarShow ? "xmark" : "line.3.horizontal")
                        .imageScale(.large)
                        .frame(maxWidth: .infinity, maxHeight: screenHeight - 150, alignment: .topLeading)
                        .onTapGesture {
                            sideBarShow.toggle()
                        }
                        .padding(.horizontal)
                    
                    VStack(spacing: 15) {
                        Text("Custom SideBar").font(.headline).fontWeight(.semibold)
                        
                        HStack {
                            Text("Swipe ")
                            Image(systemName: "arrowshape.right.fill")
                        }
                    }
                }
                .offset(x: max(min(dragging.width + position.width, sideMenuWidth), 0))
                
                SideMenu_ZStack()
                    .offset(x: -sideMenuWidth)
                    .offset(x: max(min(dragging.width + position.width, sideMenuWidth), 0))
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        withAnimation(.linear) {
                            if position.width == 0 && value.translation.width < 0 {
                                self.dragging = .zero
                            } else {
                                self.dragging = value.translation
                            }
                        }
                    }
                    .onEnded { value in
                        let threshold: CGFloat = 90.0
                        withAnimation(.linear) {
                            if value.translation.width >= threshold {
                                self.position.width = sideMenuWidth
                                self.dragging = .zero
                            } else if value.translation.width <= -threshold && position.width == sideMenuWidth {
                                self.position.width = .zero
                                self.dragging = .zero
                            } else {
                                self.dragging = .zero
                            }
                        }

                        if value.translation.width >= threshold {
                            self.sideBarShow = true
                        } else if value.translation.width <= -threshold {
                            self.sideBarShow = false
                        }
                    }
            )
        }
        .ignoresSafeArea(edges: .all)
        .onChange(of: sideBarShow) {
            withAnimation {
                if sideBarShow {
                    dragging.width = sideMenuWidth
                    position.width = sideMenuWidth
                } else {
                    dragging.width = .zero
                    position.width = .zero
                }
            }
        }
    }
}

#Preview {
    HomeView_ZStack()
}
