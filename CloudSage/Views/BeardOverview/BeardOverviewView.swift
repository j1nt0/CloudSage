//
//  BeardOverviewView.swift
//  CloudSage
//
//  Created by Jin Lee on 8/8/24.
//

import SwiftUI
import SwiftData

struct BeardOverviewView: View {
    
    @State var cloudData: CloudData
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
                    CustomBeardView().offset(y: 190)
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
            doYouWantChangeView()
            doYouWantRemoveView(index: selectedRemoveCloudIndex ?? 0)
            doYouWantRemoveAllView()
        }
        .onAppear {
            cloudData.fetchData()
        }
        .onDisappear {
            for index in cloudData.clouds.indices {
                if cloudData.clouds[index].isShowReal == false && cloudData.clouds[index].isShow == true {
                    cloudData.clouds[index].isShow = false
                }
            }
            cloudDB[0].clouds = cloudData.clouds
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
                VStack(spacing: 4) {
                    ResetButton()
                    DeleteButton()
                }
                ForEach(0..<cloudData.clouds.count) { rowIndex in
                    VStack(spacing: 4) {
                        ForEach(0..<2) { columnIndex in
                            let itemIndex = rowIndex * 2 + columnIndex
                            if itemIndex < cloudData.clouds.count {
                                BeardBlock(cloud: cloudData.clouds[itemIndex])
                                    .onTapGesture {
                                        // MARK: 아이템들이 나오게끔
                                        if cloudData.clouds[itemIndex].isShow {
                                            cloudData.clouds[itemIndex].isShow = false
                                            cloudData.clouds[itemIndex].imagePosition = CGPoint(x: 50, y: 50)
                                        } else {
                                            cloudData.clouds[itemIndex].isShow = true
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
                                cloudData.updateData()    
                                cloudDB[0].clouds = cloudData.clouds
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
                                cloudData.removeData(index: index)
                                cloudDB[0].clouds = cloudData.clouds
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
    @ViewBuilder
    func doYouWantRemoveAllView() -> some View {
        if bovm.doYouWantRemoveAll {
            ZStack {
                Color.black.opacity(0.3).ignoresSafeArea()
                ZStack {
                    RoundedRectangle(cornerRadius: 21)
                        .foregroundStyle(.white)
                    VStack {
                        VStack(spacing: 10) {
                            Text("모든 수염들을")
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
                                cloudData.clouds.removeAll()
//                                cloudDB[0].clouds.removeAll()
                                bovm.doYouWantRemoveAll = false
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
                                bovm.doYouWantRemoveAll = false
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
            cloudData.clouds = cloudData.clouds.map { cloud in
                var mutableCloud = cloud
                mutableCloud.isShow = false
                mutableCloud.imagePosition = CGPoint(x: 8, y: 40)
                return mutableCloud
            }
        }
    }
    func DeleteButton() -> some View {        
        ZStack {
            RoundedRectangle(cornerRadius: 13)
                .foregroundStyle(.whiteShadow)
                .frame(width: 78, height: 78)
                .offset(y: 4)
            ZStack {
                RoundedRectangle(cornerRadius: 13)
                    .foregroundStyle(.white)
                Image(.delete)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .frame(width: 78, height: 78)
        }
        .frame(height: 88)
        .onTapGesture {
            bovm.doYouWantRemoveAll = true
        }
    }
    func CustomBeardView() -> some View {
        ZStack {
            ForEach(cloudData.clouds.indices, id: \.self) { index in
                let cloud = cloudData.clouds[index]
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
                                    cloudData.clouds[index].dragOffset = value.translation
                                }
                                .onEnded { value in
                                    // 드래그가 끝나면 최종 위치를 저장
                                    cloudData.clouds[index].imagePosition.x += cloudData.clouds[index].dragOffset.width
                                    cloudData.clouds[index].imagePosition.y += cloudData.clouds[index].dragOffset.height
                                    cloudData.clouds[index].dragOffset = .zero
                                }
                        )
                }
            }
        }
    }
}

#Preview {
    BeardOverviewView(cloudData: CloudData(), vm: MainViewModel(), path: .constant(NavigationPath()))
}
