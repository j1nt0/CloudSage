//
//  SkinModel.swift
//  CloudSage
//
//  Created by Jin Lee on 8/7/24.
//

import Foundation
import SwiftData

struct Skin: Codable {
    var skinTitle: String
    var skinString: String
    var isPremium: Bool
    var isUnLock: Bool
    var price: Int
}

@Model
class SkinsData {
    var skins: [Skin] = []
    
    init() {
        skins = [
            Skin(skinTitle: "수염이 없수염", skinString: "SkinNone", isPremium: false, isUnLock: true, price: 0),
                        Skin(skinTitle: "구름영감님의 잃어버린 수염", skinString: "SkinDefaultBeard", isPremium: false, isUnLock: true, price: 0),
                        Skin(skinTitle: "하얼빈 맥주로 염색한 수염", skinString: "SkinYellowBeard", isPremium: false, isUnLock: true, price: 0),
                        Skin(skinTitle: "소개팅 전날 분칠한 수염", skinString: "SkinPinkBeard", isPremium: false, isUnLock: true, price: 0),
                        Skin(skinTitle: "구름렌즈 원데이 블루", skinString: "SkinBlueLens", isPremium: true, isUnLock: false, price: 30),
                        Skin(skinTitle: "구름렌즈 원데이 그린", skinString: "SkinGreenLens", isPremium: true, isUnLock: false, price: 30),
                        Skin(skinTitle: "핑크 거대 토끼", skinString: "SkinPinkGiantRabbit", isPremium: true, isUnLock: false, price: 50),
                        Skin(skinTitle: "테무에서 산 한교동", skinString: "SkinZZabGyoDong", isPremium: true, isUnLock: false, price: 50),
                        Skin(skinTitle: "하암 피고내..", skinString: "SkinTired", isPremium: true, isUnLock: false, price: 50),
//                        Skin(skinTitle: "한껏 포근해진 영감", skinString: "SkinBear", isPremium: true, isUnLock: false, price: 50),
                        Skin(skinTitle: "나 구름영감 아니다", skinString: "SkinGhost", isPremium: true, isUnLock: false, price: 50),
                        Skin(skinTitle: "구름퀸", skinString: "SkinQueen", isPremium: true, isUnLock: false, price: 100),
                        Skin(skinTitle: "왠지 수상한 가면", skinString: "SkinCriminal", isPremium: true, isUnLock: false, price: 100),
                    ]
    }
}
