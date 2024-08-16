//
//  ShareView.swift
//  CloudSage
//
//  Created by Jin Lee on 8/14/24.
//

import SwiftUI
import UIKit

struct ShareView: View {
    var vm: MainViewModel
    var cloudData: CloudData
    @State var screenCapture: UIImage = UIImage()
    
    var body: some View {
        ZStack {
            Color.sky01.ignoresSafeArea()
            VStack(spacing: 0) {
                ZStack {
                    CloudSageDefaultImage()
                    CloudSageSkinImage(skin: vm.CloudSageSkin)
                    CustomBeardView()
                        .offset(y: 190)
                }
                Ellipse()
                    .frame(width: 130, height: 40)
                    .foregroundStyle(.black).opacity(0.06)
            }
            .offset(y: -30)
            VStack {
                Spacer()
                ShareLink(
                    item: Image(uiImage: screenCapture),
                    preview: SharePreview("구름영감의 행복한 한때", image: Image(uiImage: screenCapture))
                ) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(.bottom, 30)
                }
            }
        }
        .onAppear {
            screenCapture = takeCapture()
            screenCapture = screenCapture.toSquareImage() ?? UIImage()
        }
    }
    func CustomBeardView() -> some View {
        ZStack {
            ForEach(cloudData.clouds.indices, id: \.self) { index in
                let cloud = cloudData.clouds[index]
                if cloud.isShowReal {
                    Image(uiImage: cloud.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                        .offset(x: cloud.imagePositionReal.x, y: cloud.imagePositionReal.y)
                }
            }
        }
    }
    func takeCapture() -> UIImage {
        var image: UIImage?
        guard let currentLayer = UIApplication.shared.windows.first { $0.isKeyWindow }?.layer else { return UIImage() }
        
        let currentScale = UIScreen.main.scale
        
        UIGraphicsBeginImageContextWithOptions(currentLayer.frame.size, false, currentScale)
        
        guard let currentContext = UIGraphicsGetCurrentContext() else { return UIImage() }
        
        currentLayer.render(in: currentContext)
        
        image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image ?? UIImage()
    }
}

#Preview {
    ShareView(vm: MainViewModel(), cloudData: CloudData())
}
