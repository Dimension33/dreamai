//
//  HapticsManager.swift
//
//  Created on 12/12/2025.
//

import CoreHaptics
import UIKit

/// A manager class that handles haptic feedback throughout the app.
/// Gracefully degrades to UIFeedbackGenerator when Core Haptics is unavailable (e.g., on Simulator).
class HapticsManager {
    static let shared = HapticsManager()
    
    private var engine: CHHapticEngine?
    private var supportsHaptics = false
    
    private init() {
        setupHaptics()
    }
    
    private func setupHaptics() {
        // Check if the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            print("Device doesn't support Core Haptics - will use UIFeedbackGenerator fallback")
            return
        }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
            supportsHaptics = true
            
            // Handle engine reset (e.g., when app goes to background)
            engine?.resetHandler = { [weak self] in
                print("Haptic engine reset")
                do {
                    try self?.engine?.start()
                } catch {
                    print("Failed to restart haptic engine: \(error)")
                }
            }
            
            // Handle engine stopped
            engine?.stoppedHandler = { reason in
                print("Haptic engine stopped: \(reason)")
            }
            
        } catch {
            print("Failed to create haptic engine: \(error)")
            supportsHaptics = false
        }
    }
    
    // MARK: - Simple Feedback Methods
    
    /// Play a light impact haptic
    func playLight() {
        if supportsHaptics {
            playCustomPattern(intensity: 0.5, sharpness: 0.3)
        } else {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
    }
    
    /// Play a medium impact haptic
    func playMedium() {
        if supportsHaptics {
            playCustomPattern(intensity: 0.7, sharpness: 0.5)
        } else {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }
    }
    
    /// Play a heavy impact haptic
    func playHeavy() {
        if supportsHaptics {
            playCustomPattern(intensity: 1.0, sharpness: 0.7)
        } else {
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        }
    }
    
    /// Play a success notification haptic
    func playSuccess() {
        if supportsHaptics {
            playCustomPattern(intensity: 1.0, sharpness: 0.5)
        } else {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
    }
    
    /// Play an error notification haptic
    func playError() {
        if supportsHaptics {
            playCustomPattern(intensity: 1.0, sharpness: 1.0)
        } else {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        }
    }
    
    /// Play a warning notification haptic
    func playWarning() {
        if supportsHaptics {
            playCustomPattern(intensity: 0.8, sharpness: 0.8)
        } else {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
        }
    }
    
    /// Play a selection changed haptic (like scrolling through a picker)
    func playSelection() {
        // This one uses UISelectionFeedbackGenerator for both cases
        // as it's optimized for rapid repeated calls
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
    
    // MARK: - Custom Patterns
    
    /// Play a custom haptic pattern with specified intensity and sharpness
    /// - Parameters:
    ///   - intensity: The strength of the haptic (0.0 to 1.0)
    ///   - sharpness: The "crispness" of the haptic (0.0 to 1.0)
    private func playCustomPattern(intensity: Float, sharpness: Float) {
        guard let engine = engine else { return }
        
        do {
            let intensityParam = CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity)
            let sharpnessParam = CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness)
            
            let event = CHHapticEvent(
                eventType: .hapticTransient,
                parameters: [intensityParam, sharpnessParam],
                relativeTime: 0
            )
            
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: CHHapticTimeImmediate)
        } catch {
            print("Failed to play custom haptic pattern: \(error)")
        }
    }
    
    /// Play a complex haptic pattern with multiple events
    /// - Parameter events: Array of haptic events to play
    func playPattern(events: [CHHapticEvent]) {
        guard supportsHaptics, let engine = engine else {
            // Fallback to simple impact
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            return
        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: CHHapticTimeImmediate)
        } catch {
            print("Failed to play haptic pattern: \(error)")
        }
    }
}

// MARK: - Example Usage
/*
 
 // Simple haptics:
 HapticsManager.shared.playSuccess()
 HapticsManager.shared.playError()
 HapticsManager.shared.playLight()
 HapticsManager.shared.playMedium()
 HapticsManager.shared.playHeavy()
 HapticsManager.shared.playSelection()
 
 // Custom pattern:
 let events = [
     CHHapticEvent(eventType: .hapticTransient,
                   parameters: [
                       CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                       CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
                   ],
                   relativeTime: 0),
     CHHapticEvent(eventType: .hapticTransient,
                   parameters: [
                       CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5),
                       CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)
                   ],
                   relativeTime: 0.1)
 ]
 HapticsManager.shared.playPattern(events: events)
 
 */
