//
//  BeardDesignViewModel.swift
//  CloudSage
//
//  Created by Jin Lee on 8/7/24.
//

import Foundation

@Observable
class BeardDesignViewModel {
    var selectedSkin: Skin?
    var doYouWantChange: Bool = false
    var doYouWantUnLock: Bool = false
    var doYouWantEarnPoint: Bool = false
//    var skinData = SkinsData()
    var didYouAcquirePoint: Bool = false
    var isAttendance: Bool = false
}
