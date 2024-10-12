//
//  BeardDesignView.swift
//  CloudSage
//
//  Created by Jin Lee on 8/6/24.
//

import SwiftUI
import SwiftData
import GoogleMobileAds

struct BeardDesignView: View {
    
    var vm: MainViewModel
    @State var bdvm = BeardDesignViewModel()
    @Binding var path: NavigationPath
    @Query var skinDB: [SkinsData]
    @ObservedObject var viewModel = RewardedViewModel()
//    @State var myPoint: Int = 600
    @State var canIShacking: Bool = false
    @AppStorage("Point") private var point: Int = 0
    @AppStorage("Date") private var attendanceDate: String = "2024-09-25"
    @State var a: LocalizedStringKey = ""
    @State var b: LocalizedStringKey = ""
    @State var randomPoint = 0
    
    let points = [20, 30, 40, 50]
    
    var body: some View {
        ZStack {
            Color.sky01.ignoresSafeArea()
            VStack(spacing: 0) {
                ZStack {
                    CloudSageDefaultImage()
                    CloudSageSkinImage(skin: bdvm.selectedSkin ?? Skin(skinTitle: "수염이 없수염", skinString: "skinNone", isPremium: false, isUnLock: true, price: 0))
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
            PointView()
            doYouWantChangeView()
            doYouWantUnLockView()
            doYouWantEarnPointView()
            acquireView(aText: a, bText: b)
            acquireView2(aText: a, bText: b)
        }
        .onAppear {
            bdvm.selectedSkin = vm.CloudSageSkin
            checkDate()
            Task {
                await viewModel.loadAd()
            }
        }
    }
}

extension BeardDesignView {
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
                                        Image("coinImage")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 19)
                                        Text(String(bdvm.selectedSkin?.price ?? 0))
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundStyle(.coin)
                                    }
                                    .rotationEffect(Angle(degrees: rotateDegree())) // 흔들릴 각도 설정
                                    .animation(
                                        Animation.easeInOut(duration: 0.1)
                                            .repeatCount(canIShacking ? 5 : 0, autoreverses: true), // 1초 동안 반복
                                        value: canIShacking
                                    )
                                }
                                .frame(width: 206, height: 54)
                                .onTapGesture {
                                    guard let selectedSkin = bdvm.selectedSkin else { return }
                                    if point < selectedSkin.price {
                                        canIShacking = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            canIShacking = false
                                        }
                                    } else {
                                        // selectedSkin 안됨
                                        bdvm.selectedSkin?.isUnLock = true
                                        if let index = skinDB[0].skins.firstIndex(where: { $0.skinTitle == bdvm.selectedSkin?.skinTitle }) {
                                            skinDB[0].skins[index].isUnLock = true
                                        }
                                        point -= selectedSkin.price
//                                        UserDefaults.standard.setValue(onBoardingFinish, forKey: "OnBoardingFinish")
                                        bdvm.doYouWantUnLock = false
                                    }
                                }
                                // MARK: - 영상 시청 광고 시작
//                                ZStack {
//                                    RoundedRectangle(cornerRadius: 13)
//                                        .foregroundStyle(.sky01Shadow)
//                                        .offset(y: 5)
//                                    RoundedRectangle(cornerRadius: 13)
//                                        .foregroundStyle(.sky01)
//                                    Image(systemName: "play.rectangle.fill")
//                                        .font(.system(size: 20, weight: .bold))
//                                        .foregroundStyle(.white)
//                                }
//                                .frame(width: 115, height: 54)
//                                .onTapGesture {
//                                    viewModel.showAd()
//                                    
//                                    if viewModel.success {
//                                        bdvm.selectedSkin?.isUnLock = true
//                                        if let index = skinDB[0].skins.firstIndex(where: { $0.skinTitle == bdvm.selectedSkin?.skinTitle }) {
//                                            skinDB[0].skins[index].isUnLock = true
//                                        }
//                                        
//                                        viewModel.offSuccess()
//                                    }
//                                    bdvm.doYouWantUnLock = false
//                                }
                                // MARK: - 영상 시청 광고 끝
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
    func rotateDegree() -> CGFloat {
        if canIShacking {
            return canIShacking ? 5 : -5
        } else {
            return 0
        }
    }
    func PointView() -> some View {
        VStack {
            HStack {
                Spacer()
                ZStack {
                    Image(.myPointBackground)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    HStack {
                        HStack(spacing: 5) {
                            Image("coinImage")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 19)
                            Text(String(point))
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(.coin)
                        }
                        Spacer()
                        Image(systemName: "plus.app.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24)
                            .foregroundStyle(LinearGradient(colors: [.sky01, .sky02], startPoint: .top, endPoint: .bottom))
                            .padding(.trailing, 10)
                    }
                    .padding(.leading, 9)
                }
                .frame(width: 125)
                .onTapGesture {
                    bdvm.doYouWantEarnPoint = true
                }
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    func doYouWantEarnPointView() -> some View {
        if bdvm.doYouWantEarnPoint {
            ZStack {
                Color.black.opacity(0.3).ignoresSafeArea()
                ZStack {
                    RoundedRectangle(cornerRadius: 21)
                        .foregroundStyle(.white)
                    VStack(spacing: 0) {
                        VStack(spacing: 42) {
                            // 출석 도장
                            HStack(alignment: .top, spacing: 0) {
                                EarnPointVStack(aText: "출석 도장", bText: "10")
                                Spacer()
                                if bdvm.isAttendance {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 13)
                                            .foregroundStyle(.cancelGrayShadow)
                                            .offset(y: 5)
                                        RoundedRectangle(cornerRadius: 13)
                                            .foregroundStyle(.cancelGray)
                                        Text("완료")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundStyle(.white)
                                    }
                                    .frame(width: 109, height: 54)
                                } else {
                                    EarnPointButton(cText: "무료")
                                        .onTapGesture {
                                            bdvm.doYouWantEarnPoint = false
                                            point += 10
                                            bdvm.isAttendance = true
                                            attendanceDate = dateToString(date: Date())
                                            a = "10"
                                            b = "출석했습니다!"
                                            bdvm.didYouAcquirePoint = true
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                withAnimation {
                                                    bdvm.didYouAcquirePoint = false
                                                }
                                            }
                                        }
                                }
                                
                            }
                            // 광고 시청
                            HStack(alignment: .top, spacing: 0) {
                                EarnPointVStack(aText: "광고 시청", bText: "20 ~ 50")
                                Spacer()
                                EarnPointButton(cText: "무료")
                                    .onTapGesture {
//                                        viewModel.showAd()
//
//                                        if viewModel.success {
//                                            randomPoint = points.randomElement()!
//                                            point += randomPoint
//                                            
//                                            bdvm.doYouWantEarnPoint = false
//                                            a = "\(randomPoint)"
//                                            b = "획득했습니다!"
//                                            bdvm.didYouAcquirePoint = true
//                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//                                                withAnimation {
//                                                    bdvm.didYouAcquirePoint = false
//                                                }
//                                            }
//                                            
//                                            viewModel.offSuccess()
//                                        }           
                                        viewModel.showAd()
                                        
                                        randomPoint = points.randomElement()!
//                                        point += randomPoint
                                        
                                        bdvm.doYouWantEarnPoint = false
                                        a = "\(randomPoint)"
                                        b = "획득했습니다!"
//                                        bdvm.didYouAcquirePoint = true
//                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                                            withAnimation {
//                                                bdvm.didYouAcquirePoint = false
//                                            }
//                                        }
                                    }
                            }
                            // 코인 구매
                            HStack(alignment: .top, spacing: 0) {
                                EarnPointVStack(aText: "코인 구매", bText: "100")
                                Spacer()
                                EarnPointButton(cText: "₩1,100")
                            }
                        }
                        .padding(.top, 42)
                        Spacer()
                        Text("Not Now")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundStyle(.sky01)
                            .onTapGesture {
                                bdvm.doYouWantEarnPoint = false
                            }
                            .padding(.bottom, 17)
                    }
                    .padding(.horizontal, 18)
                }
                .frame(height: 371)
                .padding(.horizontal, 15)
            }
        }
    }
    
    func EarnPointVStack(aText: LocalizedStringKey, bText: String) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(aText)
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(.mainSubFont)
            HStack(spacing: 5) {
                Image("coinImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 19, height: 19)
                Text(bText)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.coin)
            }
        }
    }
    
    func EarnPointButton(cText: LocalizedStringKey) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 13)
                .foregroundStyle(.sky01Shadow)
                .offset(y: 5)
            RoundedRectangle(cornerRadius: 13)
                .foregroundStyle(.sky01)
            Text(cText)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.white)
        }
        .frame(width: 109, height: 54)
    }
    
    func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let formattedDate = dateFormatter.string(from: date)
        
        return formattedDate
    }
    
    func checkDate() {
        let todayDate = Date()

        if attendanceDate == dateToString(date: todayDate) {
            bdvm.isAttendance = true
        } else {
            bdvm.isAttendance = false
        }
        print(attendanceDate)
    }
    
    @ViewBuilder
    func acquireView(aText: LocalizedStringKey, bText: LocalizedStringKey) -> some View {
        if viewModel.adFinished {
            ZStack {
                Color.black.opacity(0.3).ignoresSafeArea()
                    .onTapGesture {
                        viewModel.adFinished = false
                    }
                ZStack {
                    RoundedRectangle(cornerRadius: 21)
                        .foregroundStyle(.white)
                    VStack(spacing: 17) {
                        Spacer()
                        HStack(spacing: 5) {
                            Image("coinImage")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                            Text(aText)
                                .font(.system(size: 26, weight: .bold))
                                .foregroundStyle(.coin)
                        }
                        .padding(.top, 30)
                        Text(bText)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.myBlack)
                            .padding(.bottom, 30)
                        Spacer()
                    }
                }
                .frame(height: 100)
                .padding(.horizontal, 15)
            }
            .onAppear {
                point += randomPoint
            }
        }
    }
    @ViewBuilder
    func acquireView2(aText: LocalizedStringKey, bText: LocalizedStringKey) -> some View {
        if bdvm.didYouAcquirePoint {
            ZStack {
                Color.black.opacity(0.3).ignoresSafeArea()
                    .onTapGesture {
                        bdvm.didYouAcquirePoint = false
                    }
                ZStack {
                    RoundedRectangle(cornerRadius: 21)
                        .foregroundStyle(.white)
                    VStack(spacing: 17) {
                        Spacer()
                        HStack(spacing: 5) {
                            Image("coinImage")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                            Text(aText)
                                .font(.system(size: 26, weight: .bold))
                                .foregroundStyle(.coin)
                        }
                        .padding(.top, 30)
                        Text(bText)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.myBlack)
                            .padding(.bottom, 30)
                        Spacer()
                    }
                }
                .frame(height: 100)
                .padding(.horizontal, 15)
            }
            .onAppear {
                point += randomPoint
            }
        }
    }
}

#Preview {
    //    BeardDesignView(vm: MainViewModel(), path: .constant(NavigationPath()))
    BeardDesignView(vm: MainViewModel(), path: .constant(.init()))
}
