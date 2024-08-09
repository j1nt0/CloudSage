//
//  ToSquareImage.swift
//  CloudSage
//
//  Created by Jin Lee on 8/8/24.
//

import UIKit
import SwiftUI

// 사진을 정방형으로 바꿔주는 익스텐션
extension UIImage {
    func toSquareImage() -> UIImage? {
        let sideLength = min(size.width, size.height)
        let squareSize = CGSize(width: sideLength, height: sideLength)
        let squareRect = CGRect(
            x: (size.width - sideLength) / 2,
            y: (size.height - sideLength) / 2,
            width: sideLength,
            height: sideLength
        )

        UIGraphicsBeginImageContextWithOptions(squareSize, false, scale)
        let context = UIGraphicsGetCurrentContext()
        
        // Draw image with the correct position to crop
        draw(in: CGRect(origin: CGPoint(x: -squareRect.origin.x, y: -squareRect.origin.y), size: size))
        
        let croppedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if croppedImage == nil {
            print("Failed to create cropped image")
        } else {
            print("Successfully created cropped image")
        }

        return croppedImage?.resized(to: CGSize(width: 300, height: 300))
    }
    func resized(to newSize: CGSize) -> UIImage? {
            UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
            draw(in: CGRect(origin: .zero, size: newSize))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return resizedImage
        }
}
