//
//  Common.swift
//  CloudSage
//
//  Created by Jin Lee on 9/11/24.
//

import SwiftUI

func SaveButton(isWhat: Binding<Bool>) -> some View {
    ZStack {
        RoundedRectangle(cornerRadius: 13)
            .foregroundStyle(.whiteShadow)
            .offset(y: 5)
        RoundedRectangle(cornerRadius: 13)
            .foregroundStyle(.white)
        Text("저장")
            .font(.system(size: 20, weight: .bold))
            .foregroundStyle(.sky01)
    }
    .onTapGesture {
        isWhat.wrappedValue = true
    }
    .frame(width: 99, height: 54)
}

func CloudSageDefaultImage() -> some View {
    Image(.nonCloudSageLogo)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 300)
}

func CloudSageSkinImage(skin: Skin) -> some View {
    if skin.skinString == "SkinNone" {
        Image("")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 300)
    } else {
        Image(skin.skinString)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 300)
    }
}

