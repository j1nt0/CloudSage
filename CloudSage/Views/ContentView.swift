//
//  ContentView.swift
//  CloudSage
//
//  Created by Jin Lee on 8/6/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    @AppStorage("OnBoardingFinish") private var onBoarding: Bool = false
    @State var onBoardingFinish: Bool = false
    @State var isDone: Bool = false
    
    var body: some View {
        if isDone {
            ZStack {
                MainView()
                if !onBoarding {
                    OnBoardingView(onBoardingFinish: $onBoardingFinish)
                }
            }
        } else {
            ProgressView()
                .onAppear {
                    addDefaultCloud()
                }
        }
    }
    private func addDefaultCloud() {
        do {
            let newCloud = CloudDB()
            modelContext.insert(newCloud)
            try modelContext.save()
            isDone = true
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    ContentView()
}
