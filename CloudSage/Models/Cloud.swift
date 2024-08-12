//
//  Cloud.swift
//  CloudSage
//
//  Created by Jin Lee on 8/8/24.
//

import Foundation
import UIKit
import SwiftData

struct Cloud: Identifiable, Codable {
    var id = UUID()
    var registrationDate: Date
    var image: UIImage? {
        get {
            if let data = imageData {
                return UIImage(data: data) ?? UIImage()
            } else {
                return UIImage()
            }
        }
        set {
            imageData = newValue?.jpegData(compressionQuality: 0.5)
        }
    }
    var imageData: Data?
    var isShow: Bool = false
    var imagePosition = CGPoint(x: 8, y: 40)
    var dragOffset = CGSize.zero
    var imagePositionReal = CGPoint(x: 8, y: 40)
    var isShowReal: Bool = false
}

@Model
class CloudDB {
    var clouds: [Cloud]
    
    init() {
        self.clouds = []
    }
    
    func resetData() {
        // Cloud 객체를 직접 수정하려면, 배열 내의 요소를 수정 가능한 값으로 처리해야 합니다.
        clouds = clouds.map { cloud in
            var mutableCloud = cloud
            mutableCloud.isShow = false
            return mutableCloud
        }
    }
    
    func fetchData() {
        clouds = clouds.map { cloud in
            var mutableCloud = cloud
            mutableCloud.imagePosition = mutableCloud.imagePositionReal
            mutableCloud.isShow = mutableCloud.isShowReal
            return mutableCloud
        }
    }
    
    func updateData() {
        clouds = clouds.map { cloud in
            var mutableCloud = cloud
            mutableCloud.imagePositionReal = mutableCloud.imagePosition
            mutableCloud.isShowReal = mutableCloud.isShow
            return mutableCloud
        }
    }
    
    func removeData(index: Int) {
        clouds.remove(at: index)
    }
}
