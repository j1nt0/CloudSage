//
//  MainView.swift
//  CloudSage
//
//  Created by Jin Lee on 8/6/24.
//

import SwiftUI

struct MainView: View {
    
    var vm = MainViewModel()
    var cvm = CameraViewModel()
    var cloudData = CloudData()
    @State var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
                ZStack {
                    VStack(spacing: 0) {
                        Spacer()
                        CloudSageImage(skin: vm.CloudSageSkin)
                            .frame(maxWidth: .infinity)
                        Image(.speechBubbleBackground)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    VStack(spacing: 17) {
                        Spacer()
                        MainButtonBox(text1: "날씨도 좋은데", text2: "내 수염 좀 찾아주시게.", goTo: CameraView(path: $path, cvm: cvm, cloudData: cloudData), goToValue: "BeardTrackView")
                        MainButtonBox(text1: "이거 보시게", text2: "자네가 찾아준 수염이라네.", goTo: BeardOverviewView(cloudData: cloudData, vm: vm), goToValue: "BeardOverviewView")
                        MainButtonBox(text1: "온 김에", text2: "내 옷장도 보고가게나.", goTo: BeardDesignView(vm: vm, path: $path), goToValue: "BeardDesignView")
                    }
                    .padding(.horizontal, 15)
                    .padding(.bottom, 40)
                }
                .navigationDestination(for: String.self) { value in
                    if value == "BeardTrackView" {
                        CameraView(path: $path, cvm: cvm, cloudData: cloudData)
                    } else if value == "BeardOverviewView" {
                        BeardOverviewView(cloudData: cloudData, vm: vm)
                    } else if value == "BeardDesignView" {
                        BeardDesignView(vm: vm, path: $path)
                    }
                }
            }
        }
    }
func MainButtonBox(text1: String, text2: String, goTo: some View, goToValue: String) -> some View {
    VStack(spacing: 4) {
        HStack {
            Text(text1)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.white)
            Spacer()
        }
        NavigationLink(value: goToValue) {
            ZStack {
                RoundedRectangle(cornerRadius: 13)
                    .foregroundStyle(.whiteShadow)
                    .offset(y: 5)
                RoundedRectangle(cornerRadius: 13)
                    .foregroundStyle(.white)
                Text(text2)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.sky02)
            }
            .frame(height: 54)
        }
    }
}


#Preview {
    MainView()
}
