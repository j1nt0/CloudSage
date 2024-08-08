//
//  BeardOverviewView.swift
//  CloudSage
//
//  Created by Jin Lee on 8/8/24.
//

import SwiftUI

struct BeardOverviewView: View {
    
    var cloudData: CloudData
    var vm: MainViewModel
    @State var bovm = BeardOverviewViewModel()
    
    var body: some View {
        ZStack {
            Color.sky01.ignoresSafeArea()
            VStack(spacing: 0) {
                CloudSageImage(skin: vm.CloudSageSkin)
                    .padding(.top, 20)
                Ellipse()
                    .frame(width: 130, height: 40)
                    .foregroundStyle(.black).opacity(0.06)
                BeardBlockScrollView()
                    .padding(.top, 70)
                Spacer()
                SaveButton(isWhat: $bovm.doYouWantChange)
                    .padding(.bottom, 15)
            }
            doYouWantChangeView()
        }
    }
    func BeardBlock(cloud: UIImage) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 13)
                .foregroundStyle(.whiteShadow)
                .frame(width: 78, height: 78)
                .offset(y: 4)
            ZStack {
                RoundedRectangle(cornerRadius: 13)
                    .foregroundStyle(.white)
                Image(uiImage: cloud)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 13))
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 78, height: 78)
            }
            .frame(width: 78, height: 78)
        }
        .frame(height: 88)
    }
    
    func BeardBlockScrollView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(0..<cloudData.clouds.count) { rowIndex in
                    VStack(spacing: 4) {
                        ForEach(0..<2) { columnIndex in
                            let itemIndex = rowIndex * 2 + columnIndex
                            if itemIndex < cloudData.clouds.count {
                                BeardBlock(cloud: cloudData.clouds[itemIndex].image!)
                                    .onTapGesture {
//                                        bdvm.selectedSkin = bdvm.skinData.skins[itemIndex]
                                        print("검거")
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
        if bovm.doYouWantChange {
            ZStack {
                Color.black.opacity(0.3).ignoresSafeArea()
                ZStack {
                    RoundedRectangle(cornerRadius: 21)
                        .foregroundStyle(.white)
                    VStack {
                        VStack(spacing: 10) {
                            Text("@@@?")
                            Text("@@@")
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
                                bovm.doYouWantChange = false
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

#Preview {
    BeardOverviewView(cloudData: CloudData(), vm: MainViewModel())
}
