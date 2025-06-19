//
//  firstPage.swift
//  MyLingoMates
//
//  Created by Danielle Naa Okailey Quaye on 4/28/25.
//

import SwiftUI

struct FirstPage: View {
    @Binding var currentView: AppView
    var body: some View {
        ZStack {
                    Color.white
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Image("lingoMatesFirst")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 1000, height: 1000)
                            .padding(.bottom, 10)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        currentView = .login
                    }
                }
            }
        }

        #Preview {
            FirstPage(currentView: .constant(.firstpage))
        }
