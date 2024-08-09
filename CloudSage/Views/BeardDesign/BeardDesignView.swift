//
//  BeardDesignView.swift
//  CloudSage
//
//  Created by Jin Lee on 8/6/24.
//

import SwiftUI

struct BeardDesignView: View {
    
    var vm: MainViewModel
    @State var bdvm = BeardDesignViewModel()
    @Binding var path: NavigationPath
    
    var body: some View {
        ZStack {
            Color.sky01.ignoresSafeArea()
            VStack(spacing: 0) {
                ZStack {
                    CloudSageDefaultImage()
                    CloudSageSkinImage(skin: bdvm.selectedSkin ?? Skin(skinTitle: "수염이 없수염", skinString: "skinNone", isPremium: false))
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
                SaveButton(isWhat: $bdvm.doYouWantChange)
                    .padding(.bottom, 15)
            }
            doYouWantChangeView()
        }
        .onAppear {
            bdvm.selectedSkin = vm.CloudSageSkin
        }
    }
    func BeardBlock(beard: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 13)
                .foregroundStyle(.whiteShadow)
                .frame(width: 78, height: 78)
                .offset(y: 4)
            ZStack {
                RoundedRectangle(cornerRadius: 13)
                    .foregroundStyle(.white)
                Image(beard)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .frame(width: 78, height: 78)
        }
        .frame(height: 88)
    }
    
    func BeardBlockScrollView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(0..<bdvm.skinData.skins.count) { rowIndex in
                    VStack(spacing: 4) {
                        ForEach(0..<2) { columnIndex in
                            let itemIndex = rowIndex * 2 + columnIndex
                            if itemIndex < bdvm.skinData.skins.count {
                                BeardBlock(beard: bdvm.skinData.skins[itemIndex].skinString)
                                    .onTapGesture {
                                        bdvm.selectedSkin = bdvm.skinData.skins[itemIndex]
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
