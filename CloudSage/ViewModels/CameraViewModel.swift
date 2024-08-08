//
//  CameraViewModel.swift
//  CloudSage
//
//  Created by Jin Lee on 8/8/24.
//

import SwiftUI
import Vision
import CoreImage.CIFilterBuiltins

@Observable
class CameraViewModel {
    var selectedImage: UIImage?
    var sticker: UIImage?
    var processingQueue = DispatchQueue(label: "ProcessingQueue")
    var isLoading: Bool = false
    
    func initData() {
        selectedImage = nil
        sticker = nil
    }
    
    func createSticker() {
        guard let inputImage = CIImage(image: selectedImage!) else {
            print("Failed to create CIImage")
            return
        }
        
        let fixedImage = removedOrientationImage(selectedImage!)
        
        guard let inputImage = CIImage(image: fixedImage) else {
            print("Failed to create CIImage")
            return
        }
        
        isLoading = true
        processingQueue.async { [self] in
            guard let maskImage = subjectMaskImage(from: inputImage) else {
                print("Failed to create mask image")
                DispatchQueue.main.async {
                    isLoading = false
                }
                return
            }
            let outputImage = apply(maskImage: maskImage, to: inputImage)
            let image = render(ciImage: outputImage)
            DispatchQueue.main.async {
                isLoading = false
                sticker = image
            }
        }
    }
    
    func subjectMaskImage(from inputImage: CIImage) -> CIImage? {
        let handler = VNImageRequestHandler(ciImage: inputImage)
        let request = VNGenerateForegroundInstanceMaskRequest()
        do {
            try handler.perform([request])
        } catch {
            print(error)
            return nil
        }
        guard let result = request.results?.first else {
            print("No observations found")
            return nil
        }
        do {
            let maskPixelBuffer = try result.generateScaledMaskForImage(forInstances: result.allInstances, from: handler)
            return CIImage(cvPixelBuffer: maskPixelBuffer)
        } catch {
            print(error)
            return nil
        }
    }

    func apply(maskImage: CIImage, to inputImage: CIImage) -> CIImage {
        let filter = CIFilter.blendWithMask()
        filter.inputImage = inputImage
        filter.maskImage = maskImage
        filter.backgroundImage = CIImage.empty()
        return filter.outputImage!
    }

    func render(ciImage: CIImage) -> UIImage {
        guard let cgImage = CIContext(options: nil).createCGImage(ciImage, from: ciImage.extent) else {
            fatalError("Failed to render CGImage")
        }
        return UIImage(cgImage: cgImage)
    }
    
    func removedOrientationImage(_ image: UIImage) -> UIImage {
        guard image.imageOrientation != .up else { return image }
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        image.draw(in: CGRect(origin: .zero, size: image.size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return normalizedImage ?? image
    }
}
