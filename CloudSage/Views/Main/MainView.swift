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
    @Binding var cloudData: CloudData
    @State var path = NavigationPath()
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            NavigationStack(path: $path) {
                ZStack {
                    Color.sky01.ignoresSafeArea()
                    VStack(spacing: 0) {
                        ZStack {
                            CloudSageDefaultImage()
                            CloudSageSkinImage(skin: vm.CloudSageSkin)
                            CustomBeardView()
                                .offset(y: 190)
                        }
                        .frame(maxWidth: .infinity)
                        .offset(y: 90)
                        Spacer()
                        Image(.speechBubbleBackground)
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.sky01RealShadow)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    VStack(spacing: 17) {
                        Spacer()
                        //                    MainButtonBox(text1: "날씨도 좋은데", text2: "내 수염 좀 찾아주시게.", goTo: CameraView(path: $path, cvm: cvm, cloudData: cloudData), goToValue: "BeardTrackView")
                        //                    MainButtonBox(text1: "이거 보시게", text2: "자네가 찾아준 수염이라네.", goTo: BeardOverviewView(cloudData: cloudData, vm: vm, path: $path), goToValue: "BeardOverviewView")
                        //                    MainButtonBox(text1: "온 김에", text2: "내 옷장도 보고가게나.", goTo: BeardDesignView(vm: vm, path: $path), goToValue: "BeardDesignView")
                        HStack(spacing: 9) {
                            NavigationLink(value: "BeardTrackView") {
                                MainButton(text: "수염 찾기")
                            }
                            VStack(spacing: 14) {
                                NavigationLink(value: "BeardOverviewView") {
                                    MainButton(text: "수염 보기")
                                }
                                HStack(spacing: 9) {
                                    NavigationLink(value: "BeardDesignView") {
                                        SubButton(text: "스킨")
                                    }
                                    NavigationLink(value: "ShareView") {
                                        SubButton(text: "공유")
                                    }
                                }
                                .frame(height: (size.width/2-12)/2-4.5)
                            }
                        }
                        .frame(height: 250)
                        .foregroundStyle(.white)
                    }
                    .padding(.horizontal, 15)
                    .padding(.bottom, 40)
                }
                .navigationDestination(for: String.self) { value in
                    if value == "BeardTrackView" {
                        CameraView(path: $path, cvm: cvm, cloudData: cloudData)
                    } else if value == "BeardOverviewView" {
                        BeardOverviewView(cloudData: cloudData, vm: vm, path: $path)
                    } else if value == "BeardDesignView" {
                        BeardDesignView(vm: vm, path: $path)
                    } else if value == "ShareView" {
                        ShareView(vm: vm, cloudData: cloudData)
                    }
                }
            }
        }
    }
    func CustomBeardView() -> some View {
        ZStack {
            ForEach(cloudData.clouds.indices, id: \.self) { index in
                let cloud = cloudData.clouds[index]
                if cloud.isShowReal {
                    Image(uiImage: cloud.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                        .offset(x: cloud.imagePositionReal.x, y: cloud.imagePositionReal.y)
                }
            }
        }
    }
    func MainButton(text: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(.whiteShadow)
                .offset(y: 5)
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(.white)
            HStack(spacing: 0) {
                VStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("영감님의")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(Color.mainSubFont)
                        Text(text)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(.black)
                    }
                    .padding(.top, 17)
                    .padding(.leading, 15)
                    Spacer()
                }
                Spacer()
            }
        }
    }
    func SubButton(text: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(.whiteShadow)
                .offset(y: 5)
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(.white)
            Text(text)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.black)
        }
    }
}
//func MainButtonBox(text1: String, text2: String, goTo: some View, goToValue: String) -> some View {
//    VStack(spacing: 4) {
//        HStack {
//            Text(text1)
//                .font(.system(size: 20, weight: .bold))
//                .foregroundStyle(.white)
//            Spacer()
//        }
//        NavigationLink(value: goToValue) {
//            ZStack {
//                RoundedRectangle(cornerRadius: 13)
//                    .foregroundStyle(.whiteShadow)
//                    .offset(y: 5)
//                RoundedRectangle(cornerRadius: 13)
//                    .foregroundStyle(.white)
//                Text(text2)
//                    .font(.system(size: 20, weight: .bold))
//                    .foregroundStyle(.sky02)
//            }
//            .frame(height: 54)
//        }
//    }
//}


#Preview {
    MainView(cloudData: .constant(CloudData()))
}
