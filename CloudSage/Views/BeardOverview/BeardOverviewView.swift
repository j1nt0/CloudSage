//
//  BeardOverviewView.swift
//  CloudSage
//
//  Created by Jin Lee on 8/8/24.
//

import SwiftUI
import SwiftData

struct BeardOverviewView: View {
    
    var vm: MainViewModel
    @State var bovm = BeardOverviewViewModel()
    @Binding var path: NavigationPath
    @State var selectedRemoveCloudIndex: Int?
    @Query var cloudDB: [CloudDB]
    
    var body: some View {
        ZStack {
            Color.sky01.ignoresSafeArea()
            VStack(spacing: 0) {
                ZStack {
                    CloudSageDefaultImage()
                    CloudSageSkinImage(skin: vm.CloudSageSkin)
                }
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
            CustomBeardView()
            doYouWantChangeView()
            doYouWantRemoveView(index: selectedRemoveCloudIndex ?? 0)
        }
        .onAppear {
            cloudDB[0].fetchData()
        }
    }
    func BeardBlock(cloud: Cloud) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 13)
                .foregroundStyle(.whiteShadow)
                .frame(width: 78, height: 78)
                .offset(y: 4)
            ZStack {
                RoundedRectangle(cornerRadius: 13)
                    .foregroundStyle(.white)
                Image(uiImage: cloud.image!)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 13))
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 78, height: 78)
                if cloud.isShow {
                    Circle()
                        .foregroundStyle(.red)
                        .frame(width: 15)
                        .offset(x: 25, y: -25)
                }
            }
            .frame(width: 78, height: 78)
        }
        .frame(height: 88)
    }
    
    func BeardBlockScrollView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(0..<cloudDB[0].clouds.count) { rowIndex in
                    VStack(spacing: 4) {
                        ForEach(0..<2) { columnIndex in
                            let itemIndex = rowIndex * 2 + columnIndex
                            if itemIndex < cloudDB[0].clouds.count {
                                BeardBlock(cloud: cloudDB[0].clouds[itemIndex])
                                    .onTapGesture {
                                        // MARK: 아이템들이 나오게끔
                                        if cloudDB[0].clouds[itemIndex].isShow {
                                            cloudDB[0].clouds[itemIndex].isShow = false
                                            cloudDB[0].clouds[itemIndex].imagePosition = CGPoint(x: 50, y: 50)
                                        } else {
                                            cloudDB[0].clouds[itemIndex].isShow = true
                                        }
                                    }
                                    .onLongPressGesture {
//                                        HapticManager()?.playSlice()
                                        bovm.doYouWantRemove = true
                                        selectedRemoveCloudIndex = itemIndex
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
                            Text("선택하신 수염들을")
                            Text("구름영감님에게 붙여줄까요?")
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
                                cloudDB[0].updateData()
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
    @ViewBuilder
    func doYouWantRemoveView(index: Int) -> some View {
        if bovm.doYouWantRemove {
            ZStack {
                Color.black.opacity(0.3).ignoresSafeArea()
                ZStack {
                    RoundedRectangle(cornerRadius: 21)
                        .foregroundStyle(.white)
                    VStack {
                        VStack(spacing: 10) {
                            Text("선택하신 수염을")
                            Text("삭제할까요?")
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
                                cloudDB[0].removeData(index: index)
                                bovm.doYouWantRemove = false
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
                                bovm.doYouWantRemove = false
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
    func ResetButton() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 13)
                .foregroundStyle(.whiteShadow)
                .frame(width: 78, height: 78)
                .offset(y: 4)
            ZStack {
                RoundedRectangle(cornerRadius: 13)
                    .foregroundStyle(.white)
                Image(.reset)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .frame(width: 78, height: 78)
        }
        .frame(height: 88)
        .onTapGesture {
            
        }
    }
    func CustomBeardView() -> some View {
        ZStack {
            ForEach(cloudDB[0].clouds.indices, id: \.self) { index in
                let cloud = cloudDB[0].clouds[index]
                if cloud.isShow {
                    Image(uiImage: cloud.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                        .offset(x: cloud.imagePosition.x + cloud.dragOffset.width, y: cloud.imagePosition.y + cloud.dragOffset.height)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    // 드래그가 진행될 때 이미지의 위치를 업데이트
                                    cloudDB[0].clouds[index].dragOffset = value.translation
                                }
                                .onEnded { value in
                                    // 드래그가 끝나면 최종 위치를 저장
                                    cloudDB[0].clouds[index].imagePosition.x += cloudDB[0].clouds[index].dragOffset.width
                                    cloudDB[0].clouds[index].imagePosition.y += cloudDB[0].clouds[index].dragOffset.height
                                    cloudDB[0].clouds[index].dragOffset = .zero
                                }
                        )
                }
            }
        }
    }
}

#Preview {
    BeardOverviewView(vm: MainViewModel(), path: .constant(NavigationPath()))
}
