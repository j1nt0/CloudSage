//
//  Cloud.swift
//  CloudSage
//
//  Created by Jin Lee on 8/8/24.
//

import Foundation
import UIKit

struct Cloud {
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
            imageData = newValue?.jpegData(compressionQuality: 1.0)
        }
    }
    var imageData: Data?
    var isShow: Bool = false
    var imagePosition = CGPoint(x: 50, y: 50)
    var dragOffset = CGSize.zero
}

@Observable
class CloudData {
    var clouds: [Cloud] = []
}
