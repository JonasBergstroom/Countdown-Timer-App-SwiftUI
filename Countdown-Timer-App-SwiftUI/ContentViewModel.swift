//
//  ContentViewModel.swift
//  Countdown-Timer-App-SwiftUI
//
//  Created by Jonas Bergström on 2022-09-26.
//

import Foundation

extension ContentView {
    final class ViewModel: ObservableObject {
        
        @Published var isActive = false
        @Published var showAlert = false
        @Published var time: String = "0:00"
        @Published var minutes: Float = 0.0 {
            didSet {
                self.time = "\(Int(minutes)):00"
            }
        }
        
        private var initTime = 0
        private var endDate = Date()
        
        func startTimer(minutes: Float) {
            self.initTime = Int(minutes)
            self.endDate = Date()
            self.isActive = true
            self.endDate = Calendar.current.date(byAdding: .minute, value: Int(minutes), to: endDate)!
        }
        
        func updateTimer() {
            guard isActive else { return }
            
            let now = Date()
            let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
            
            if diff <= 0 {
                self.isActive = false
                self.time = "0:00"
                self.showAlert = true
                return
            }
            
            let date = Date(timeIntervalSince1970: diff)
            let calender = Calendar.current
            let min = calender.component(.minute, from: date)
            let sec = calender.component(.second, from: date)
            
            self.minutes = Float(min)
            self.time = String(format: "%d:%02d", min, sec)
        }
        
        func resetTimer() {
            self.minutes = Float(initTime)
            self.isActive = false
            self.time = "0:00"
        }
    }
}
