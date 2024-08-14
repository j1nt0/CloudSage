//
//  TrackResultView.swift
//  CloudSage
//
//  Created by Jin Lee on 8/8/24.
//


import SwiftUI
import SwiftData

struct TrackResultView: View {
    
    var cvm: CameraViewModel
    var cloudData: CloudData
    @Binding var path: NavigationPath
    @State var doYouWantRegister: Bool = false
    @Query var cloudDB: [CloudDB]
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            ZStack {
                Color.sky01.ignoresSafeArea()
                Image(uiImage: cvm.sticker ?? cvm.selectedImage ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size.width-30)
                VStack {
                    ZStack {
                        Image("CloudSageSpeechBubble")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    .ignoresSafeArea()
                    Spacer()
                    ZStack {
                        SaveButton(isWhat: $doYouWantRegister)
                        HStack {
                            HomeButton()
                            Spacer()
                        }
                    }
                    .padding(.bottom, 15)
                }
                VStack {
                    if let sticker = cvm.sticker {
                        Text("\"아주 마음에 드는 수염이구나!\"")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.myBlack)
                            .padding(.top, 40)
                    } else {
                        Text("\"이건 내 수염이 아니긴 한데..\"")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.myBlack)
                            .padding(.top, 40)
                    }
                    Spacer()
                }
                doYouWantRegisterView()
            }
        }
        .navigationBarBackButtonHidden(true)
        .onDisappear {
            cvm.initData()
        }
    }
    @ViewBuilder
    func doYouWantRegisterView() -> some View {
        if doYouWantRegister {
            ZStack {
                Color.black.opacity(0.3).ignoresSafeArea()
                ZStack {
                    RoundedRectangle(cornerRadius: 21)
                        .foregroundStyle(.white)
                    VStack {
                        VStack(spacing: 10) {
                            Text("찾은 수염을 영감님께")
                            Text("가져다 드릴까요?")
                        }
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.myBlack)
                            .padding(.top, 36)
                        Spacer()
                        HStack(spacing: 9) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 13)
                                    .foregroundStyle(.sky01Shadow)
                                    .offset(y: 5)
                                RoundedRectangle(cornerRadius: 13)
                                    .foregroundStyle(.sky01)
                                Text("확인")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 165, height: 54)
                            .onTapGesture {
                                cloudData.clouds.append(Cloud(registrationDate: Date(), imageData: cvm.sticker?.pngData() ?? cvm.selectedImage?.jpegData(compressionQuality: 0.5 )))
                                cloudDB[0].clouds.append(Cloud(registrationDate: Date(), imageData: cvm.sticker?.pngData() ?? cvm.selectedImage?.jpegData(compressionQuality: 0.5 )))
                                doYouWantRegister = false
                                path = NavigationPath()
                            }
                            ZStack {
                                RoundedRectangle(cornerRadius: 13)
                                    .foregroundStyle(.cancelGrayShadow)
                                    .offset(y: 5)
                                RoundedRectangle(cornerRadius: 13)
                                    .foregroundStyle(.cancelGray)
                                Text("취소")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 165, height: 54)
                            .onTapGesture {
                                doYouWantRegister = false
                            }
                        }
                        .padding(.bottom, 19)
                    }
                }
                    .frame(height: 194)
                    .padding(.horizontal, 15)
            }
        }
    }
    func HomeButton() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 13)
                .foregroundStyle(.whiteShadow)
                .offset(y: 5)
            RoundedRectangle(cornerRadius: 13)
                .foregroundStyle(.white)
            Image(systemName: "house.fill")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.sky02)
        }
        .frame(width: 63, height: 54)
        .padding(.leading, 15)
        .onTapGesture {
            path = NavigationPath()
        }
    }
}

#Preview {
    TrackResultView(cvm: CameraViewModel(), cloudData: CloudData(), path: .constant(NavigationPath()))
}
