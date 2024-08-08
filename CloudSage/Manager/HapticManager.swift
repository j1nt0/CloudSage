//
//  CoreHapticManager.swift
//  CloudSage
//
//  Created by Jin Lee on 8/8/24.
//

import SwiftUI
import CoreHaptics

class HapticManager {
  let hapticEngine: CHHapticEngine

  init?() {
    let hapticCapability = CHHapticEngine.capabilitiesForHardware()
    guard hapticCapability.supportsHaptics else {
      return nil
    }

    do {
      hapticEngine = try CHHapticEngine()
    } catch let error {
      print("Haptic engine Creation Error: \(error)")
      return nil
    }
  }
}

extension HapticManager {
    private func slicePattern() throws -> CHHapticPattern {
        let slice = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.35),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.25)
            ],
            relativeTime: 0,
            duration: 0.25)
        
        let snip = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
            ],
            relativeTime: 0.08)
        
//        return try CHHapticPattern(events: [slice, snip], parameters: [])
        return try CHHapticPattern(events: [snip], parameters: [])
    }
}

extension HapticManager {
    func playSlice() {
      do {
        let pattern = try slicePattern()

        try hapticEngine.start()

        let player = try hapticEngine.makePlayer(with: pattern)
        
        try player.start(atTime: CHHapticTimeImmediate)
        
        hapticEngine.notifyWhenPlayersFinished { _ in
          return .stopEngine
        }
      } catch {
        print("Failed to play slice: \(error)")
      }
    }
}
