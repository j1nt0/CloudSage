//
//  ContentView.swift
//  CloudSage
//
//  Created by Jin Lee on 8/6/24.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("OnBoardingFinish") private var onBoarding: Bool = false
    @State var onBoardingFinish: Bool = false
    
    var body: some View {
        ZStack {
            MainView()
            if !onBoarding {
                OnBoardingView(onBoardingFinish: $onBoardingFinish)
            }
        }
    }
}

#Preview {
    ContentView()
}
