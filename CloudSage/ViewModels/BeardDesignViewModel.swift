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
    var skinData = SkinsData()
}
