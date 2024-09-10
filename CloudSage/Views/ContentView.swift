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
    @State var isDonee: Bool = false
    @Query var cloudDB: [CloudDB]
    @State var cloudData = CloudData()
    
    @Query var skinDB: [SkinsData]
    
    var body: some View {
        if !isDonee {
            ProgressView()
                .onAppear {
                    addDefaultCloud()
                    addDefaultSkin()
                }
        } else {
            ZStack {
                if isDone {
                    MainView(cloudData: $cloudData)
                } else {
                    ProgressView()
                        .onAppear {
                            doFirst()
                        }
                }
                if !onBoarding {
                    OnBoardingView(onBoardingFinish: $onBoardingFinish)
                }
            }
        }
    }
    
    func doFirst() {
        cloudData.clouds = cloudDB[0].clouds
        isDone = true
    }
    private func addDefaultCloud() {
        do {
            let newCloud = CloudDB()
            modelContext.insert(newCloud)
            try modelContext.save()
            isDonee = true
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func addDefaultSkin() {
        do {
            let newSkin = SkinsData()
            modelContext.insert(newSkin)
            try modelContext.save()
            isDonee = true
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    ContentView()
}
