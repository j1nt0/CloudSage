//
//  SkinModel.swift
//  CloudSage
//
//  Created by Jin Lee on 8/7/24.
//

import Foundation

struct Skin {
    var skinTitle: String
    var skinString: String
    var isPremium: Bool
    var isUnLock: Bool
}

@Observable
class SkinsData {
    let skins = [
                    Skin(skinTitle: "수염이 없수염", skinString: "SkinNone", isPremium: false, isUnLock: true),
                    Skin(skinTitle: "구름영감님의 잃어버린 수염", skinString: "SkinDefaultBeard", isPremium: false, isUnLock: true),
                    Skin(skinTitle: "하얼빈 맥주로 염색한 수염", skinString: "SkinYellowBeard", isPremium: false, isUnLock: true),
                    Skin(skinTitle: "소개팅 전날 분칠한 수염", skinString: "SkinPinkBeard", isPremium: false, isUnLock: true),
                    Skin(skinTitle: "핑크 거대 토끼", skinString: "SkinPinkGiantRabbit", isPremium: false, isUnLock: true),
                    Skin(skinTitle: "테무에서 산 한교동", skinString: "SkinZZabGyoDong", isPremium: false, isUnLock: true),
                ]
}
