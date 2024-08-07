//
//  OnBoardingView.swift
//  CloudSage
//
//  Created by Jin Lee on 8/6/24.
//

import SwiftUI

struct OnBoardingView: View {
    
//    @AppStorage("OnBoardingFinish") private var onBoarding: Bool = false
    @State private var currentIndex: Int = 0
    let typewriterTextArray = [
        "만나서 반갑다네.\n나는 구름영감이라고 하네.",
        "며칠 전 잠깐 잠이 들었는데,\n수염이 모두 사라져버렸지 뭐야.",
        "자네에게 내가 부탁을 좀 하겠네.\n내 수염을 모두 찾아와 줄 수 있겠나?"
        ]
    @State private var showButton: Bool = false
    @Binding var onBoardingFinish: Bool
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            ZStack {
                Color.sky01.ignoresSafeArea()
                VStack(spacing: 0) {
                    Spacer()
                    CloudSageImageWithShadow()
                    ZStack {
                        BackgroundBlackGradient()
                        VStack(spacing: 0) {
                            Text("구름영감")
                                .font(.system(size: 30, weight: .bold))
                                .foregroundStyle(.white)
                                .padding(.top, 46)
                            Image(.star)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: size.width-40)
                                .padding(.top, 16)
                            if currentIndex == 0 {
                                TypewriterText(fullText: typewriterTextArray[0],
                                               charactersPerInterval: 1,
                                               interval: 0.1,
                                               font: .system(size: 20, weight: .regular),
                                               onComplete: {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        currentIndex = currentIndex + 1
                                    }
                                })
                                .frame(height: 60)
                                .foregroundStyle(.white)
                                .padding(.top, 35)
                            } else if currentIndex == 1 {
                                TypewriterText(fullText: typewriterTextArray[1],
                                               charactersPerInterval: 1,
                                               interval: 0.1,
                                               font: .system(size: 20, weight: .regular),
                                               onComplete: {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        currentIndex = currentIndex + 1
                                    }
                                })
                                .frame(height: 60)
                                .foregroundStyle(.white)
                                .padding(.top, 35)
                            } else if currentIndex == 2 {
                                TypewriterText(fullText: typewriterTextArray[2],
                                               charactersPerInterval: 1,
                                               interval: 0.1,
                                               font: .system(size: 20, weight: .regular),
                                               onComplete: {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        showButton = true
                                    }
                                })
                                .frame(height: 60)
                                .foregroundStyle(.white)
                                .padding(.top, 35)
                            }
                            Spacer()
                            if showButton {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 13)
                                        .foregroundStyle(.whiteShadow)
                                        .offset(y: 5)
                                    RoundedRectangle(cornerRadius: 13)
                                        .foregroundStyle(.white)
                                    Text("네, 당연하죠!")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundStyle(.sky01)
                                }
                                .frame(width: 248, height: 47)
                                .padding(.top, 10)
                                .onTapGesture {
                                    onBoardingFinish = true
//                                    onBoarding = onBoardingFinish
                                    UserDefaults.standard.setValue(onBoardingFinish, forKey: "OnBoardingFinish")
                                }
                            }
                        }
                        .frame(height: 300)
                    }
                }
            }
        }
    }
    func CloudSageImageWithShadow() -> some View {
        
        var image = "Cloud-Sage-Logo"
        if currentIndex != 0 {
            image = "Non-Cloud-Sage-Logo"
        }
        
        return VStack(spacing: 0) {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300)
            Ellipse()
                .frame(width: 130, height: 40)
                .foregroundStyle(.black).opacity(0.06)
        }
    }
    func BackgroundBlackGradient() -> some View {
        Rectangle()
            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.black.opacity(0.34), .black.opacity(0.08)]), startPoint: .top, endPoint: .bottom))
            .ignoresSafeArea()
            .frame(height: 300)
            .padding(.top, 50)
    }
}

//#Preview {
//    OnBoardingView()
//}
