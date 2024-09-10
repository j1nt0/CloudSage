//
//  BeardDesignView.swift
//  CloudSage
//
//  Created by Jin Lee on 8/6/24.
//

import SwiftUI
import SwiftData

struct BeardDesignView: View {
    
    var vm: MainViewModel
    @State var bdvm = BeardDesignViewModel()
    @Binding var path: NavigationPath
    @Query var skinDB: [SkinsData]
    
    var body: some View {
        ZStack {
            Color.sky01.ignoresSafeArea()
            VStack(spacing: 0) {
                ZStack {
                    CloudSageDefaultImage()
                    CloudSageSkinImage(skin: bdvm.selectedSkin ?? Skin(skinTitle: "수염이 없수염", skinString: "skinNone", isPremium: false, isUnLock: true))
                }
                .padding(.top, 20)
                Ellipse()
                    .frame(width: 130, height: 40)
                    .foregroundStyle(.black).opacity(0.06)
                if let skinTitle = bdvm.selectedSkin?.skinTitle {
                    Text("\(skinTitle)")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.myBlack)
                        .padding(.top, 38)
                } else {
                    Text("확인되지 않음")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.myBlack)
                        .padding(.top, 38)
                }
                BeardBlockScrollView()
                    .padding(.top, 20)
                Spacer()
                SaveButtonInDesingView()
                    .padding(.bottom, 15)
            }
            doYouWantChangeView()
            doYouWantUnLockView()
        }
        .onAppear {
            bdvm.selectedSkin = vm.CloudSageSkin
        }
    }
    
    @ViewBuilder
    func BeardBlock(skin: Skin) -> some View {
        if skin.isUnLock {
            ZStack {
                RoundedRectangle(cornerRadius: 13)
                    .foregroundStyle(.whiteShadow)
                    .frame(width: 78, height: 78)
                    .offset(y: 4)
                ZStack {
                    RoundedRectangle(cornerRadius: 13)
                        .foregroundStyle(.white)
                    Image(skin.skinString)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 78, height: 78)
            }
            .frame(height: 88)
        } else {
            ZStack {
                RoundedRectangle(cornerRadius: 13)
                    .foregroundStyle(.whiteShadowShadow)
                    .frame(width: 78, height: 78)
                    .offset(y: 4)
                ZStack {
                    RoundedRectangle(cornerRadius: 13)
                        .foregroundStyle(.whiteShadow)
                    Image(.lock)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 78, height: 78)
            }
            .frame(height: 88)
        }
    }
    
    func BeardBlockScrollView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(0..<skinDB[0].skins.count) { rowIndex in
                    VStack(spacing: 4) {
                        ForEach(0..<2) { columnIndex in
                            let itemIndex = rowIndex * 2 + columnIndex
                            if itemIndex < skinDB[0].skins.count {
                                BeardBlock(skin: skinDB[0].skins[itemIndex])
                                    .onTapGesture {
                                        bdvm.selectedSkin = skinDB[0].skins[itemIndex]
                                    }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 15)
        }
    }
    
    @ViewBuilder
    func doYouWantChangeView() -> some View {
        if bdvm.doYouWantChange {
            ZStack {
                Color.black.opacity(0.3).ignoresSafeArea()
                ZStack {
                    RoundedRectangle(cornerRadius: 21)
                        .foregroundStyle(.white)
                    VStack {
                        VStack(spacing: 10) {
                            if let skinTitle = bdvm.selectedSkin?.skinTitle {
                                Text("'\(skinTitle)'")
                            }
                            Text("착용할까요?")
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
                                if let selectedSkin = bdvm.selectedSkin {
                                    vm.CloudSageSkin = selectedSkin
                                    bdvm.doYouWantChange = false
                                    path = NavigationPath()
                                } else {
                                    print("[BeardDesignView] 확인버튼 안됨")
                                }
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
                                bdvm.doYouWantChange = false
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
    @ViewBuilder
    func doYouWantUnLockView() -> some View {
        if bdvm.doYouWantUnLock {
            ZStack {
                Color.black.opacity(0.3).ignoresSafeArea()
                ZStack {
                    RoundedRectangle(cornerRadius: 21)
                        .foregroundStyle(.white)
                    VStack {
                        VStack(spacing: 10) {
                            if let skinTitle = bdvm.selectedSkin?.skinTitle {
                                Text("'\(skinTitle)'")
                            }
                            Text("획득할까요?")
                        }
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.myBlack)
                        .padding(.top, 36)
                        Spacer()
                        VStack(spacing: 17) {
                            HStack(spacing: 9) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 13)
                                        .foregroundStyle(.sky01Shadow)
                                        .offset(y: 5)
                                    RoundedRectangle(cornerRadius: 13)
                                        .foregroundStyle(.sky01)
                                    HStack(spacing: 5) {
                                        Image(systemName: "eurosign.circle.fill")
                                        Text("700")
                                    }
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundStyle(.coin)
                                }
                                .frame(width: 206, height: 54)
                                .onTapGesture {
                                    bdvm.selectedSkin?.isUnLock = true
                                    if let index = skinDB[0].skins.firstIndex(where: { $0.skinTitle == bdvm.selectedSkin?.skinTitle }) {
                                        skinDB[0].skins[index].isUnLock = true
                                        }
                                    bdvm.doYouWantUnLock = false
                                }
                                ZStack {
                                    RoundedRectangle(cornerRadius: 13)
                                        .foregroundStyle(.sky01Shadow)
                                        .offset(y: 5)
                                    RoundedRectangle(cornerRadius: 13)
                                        .foregroundStyle(.sky01)
                                    Image(systemName: "play.rectangle.fill")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundStyle(.white)
                                }
                                .frame(width: 115, height: 54)
                                .onTapGesture {
                                    bdvm.doYouWantUnLock = false
                                }
                            }
                            Text("Not Now")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundStyle(.sky01)
                                .onTapGesture {
                                    bdvm.doYouWantUnLock = false
                                }
                        }
                        .padding(.bottom, 17)
                    }
                }
                    .frame(height: 220)
                    .padding(.horizontal, 15)
            }
        }
    }
    @ViewBuilder
    func SaveButtonInDesingView() -> some View {
        if let isUnLock = bdvm.selectedSkin?.isUnLock {
            if isUnLock {
                ZStack {
                    RoundedRectangle(cornerRadius: 13)
                        .foregroundStyle(.whiteShadow)
                        .offset(y: 5)
                    RoundedRectangle(cornerRadius: 13)
                        .foregroundStyle(.white)
                    Text("저장")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.sky01)
                }
                .onTapGesture {
                    bdvm.doYouWantChange = true
                }
                .frame(width: 99, height: 54)
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 13)
                        .foregroundStyle(.whiteShadow)
                        .offset(y: 5)
                    RoundedRectangle(cornerRadius: 13)
                        .foregroundStyle(.white)
                    Text("획득")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.sky01)
                }
                .onTapGesture {
                    bdvm.doYouWantUnLock = true
                }
                .frame(width: 99, height: 54)
            }
        } else {
            EmptyView()
        }
    }

}
func SaveButton(isWhat: Binding<Bool>) -> some View {
    ZStack {
        RoundedRectangle(cornerRadius: 13)
            .foregroundStyle(.whiteShadow)
            .offset(y: 5)
        RoundedRectangle(cornerRadius: 13)
            .foregroundStyle(.white)
        Text("저장")
            .font(.system(size: 20, weight: .bold))
            .foregroundStyle(.sky01)
    }
    .onTapGesture {
        isWhat.wrappedValue = true
    }
    .frame(width: 99, height: 54)
}

func CloudSageDefaultImage() -> some View {
    Image(.nonCloudSageLogo)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 300)
}

func CloudSageSkinImage(skin: Skin) -> some View {
        if skin.skinString == "SkinNone" {
            Image("")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300)
        } else {
            Image(skin.skinString)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300)
        }
}

#Preview {
//    BeardDesignView(vm: MainViewModel(), path: .constant(NavigationPath()))
    BeardDesignView(vm: MainViewModel(), path: .constant(.init()))
}
