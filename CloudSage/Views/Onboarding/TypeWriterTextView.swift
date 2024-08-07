//
//  SwiftUIView.swift
//  CloudSage
//
//  Created by Jin Lee on 8/6/24.
//

import SwiftUI

struct TypewriterText: View {
    // Properties
    let fullText: String
    let charactersPerInterval: Int
    let interval: TimeInterval
    let font: Font
    let onComplete: () -> Void
    
    // State variables
    @State private var displayedText: String = ""
    @State private var currentIndex: Int = 0
    @State private var timer: Timer? = nil
    
    // Body of the view
    var body: some View {
        // Displaying the text
        Text(displayedText)
            .font(font)
            .multilineTextAlignment(.center)
            .lineSpacing(10)
            .onAppear {
                startTypingAnimation()
            }
            .onDisappear {
                timer?.invalidate()
            }
    }
    
    // Function to start the typing animation
    private func startTypingAnimation() {
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            updateDisplayedText()
        }
    }
    
    // Function to update the displayed text
    private func updateDisplayedText() {
        guard currentIndex < fullText.count else {
            timer?.invalidate()
            onComplete()
            return
        }
        
        let endIndex = fullText.index(fullText.startIndex, offsetBy: min(currentIndex + charactersPerInterval, fullText.count))
        displayedText = String(fullText[..<endIndex])
        
        currentIndex += charactersPerInterval
    }
}

#Preview {
    TypewriterText(fullText: "안녕하세요", charactersPerInterval: 1, interval: 0.1, font: .system(size: 20), onComplete: {})
}
