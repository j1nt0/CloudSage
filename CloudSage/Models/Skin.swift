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
                        Skin(skinTitle: "15년 전 구름총각 시절", skinString: "SkinPaul", isPremium: true, isUnLock: false, price: 50),
                        Skin(skinTitle: "엘프가 될뻔한 영감", skinString: "SkinElf", isPremium: true, isUnLock: false, price: 50),
                        Skin(skinTitle: "핑크 거대 토끼", skinString: "SkinPinkGiantRabbit", isPremium: true, isUnLock: false, price: 100),
                        Skin(skinTitle: "테무에서 산 한교동", skinString: "SkinZZabGyoDong", isPremium: true, isUnLock: false, price: 100),
                        Skin(skinTitle: "무슨무슨 퀸", skinString: "SkinQueen", isPremium: true, isUnLock: false, price: 200),
                        Skin(skinTitle: "왠지 수상한 가면", skinString: "SkinCriminal", isPremium: true, isUnLock: false, price: 200),
                        Skin(skinTitle: "하암 피고내..", skinString: "SkinTired", isPremium: true, isUnLock: false, price: 300),
                        Skin(skinTitle: "곰도링", skinString: "SkinBear", isPremium: true, isUnLock: false, price: 300),
                        Skin(skinTitle: "나 구름영감 아니다", skinString: "SkinGhost", isPremium: true, isUnLock: false, price: 700),
                    ]
    }
}
