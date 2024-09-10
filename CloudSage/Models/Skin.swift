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
}

@Model
class SkinsData {
    var skins: [Skin] = []
    
    init() {
        skins = [
                        Skin(skinTitle: "수염이 없수염", skinString: "SkinNone", isPremium: false, isUnLock: true),
                        Skin(skinTitle: "구름영감님의 잃어버린 수염", skinString: "SkinDefaultBeard", isPremium: false, isUnLock: true),
                        Skin(skinTitle: "하얼빈 맥주로 염색한 수염", skinString: "SkinYellowBeard", isPremium: false, isUnLock: true),
                        Skin(skinTitle: "소개팅 전날 분칠한 수염", skinString: "SkinPinkBeard", isPremium: false, isUnLock: true),
                        Skin(skinTitle: "핑크 거대 토끼", skinString: "SkinPinkGiantRabbit", isPremium: false, isUnLock: true),
                        Skin(skinTitle: "테무에서 산 한교동", skinString: "SkinZZabGyoDong", isPremium: false, isUnLock: true),
                        Skin(skinTitle: "문방구에서 산 컬러렌즈", skinString: "SkinLens", isPremium: false, isUnLock: true),
                        Skin(skinTitle: "무슨무슨 퀸", skinString: "SkinQueen", isPremium: true, isUnLock: false),
                        Skin(skinTitle: "왠지 강해보이는..", skinString: "SkinPaul", isPremium: true, isUnLock: false),
                        Skin(skinTitle: "왠지 수상한 가면", skinString: "SkinCriminal", isPremium: true, isUnLock: false),
                    ]
    }
}
