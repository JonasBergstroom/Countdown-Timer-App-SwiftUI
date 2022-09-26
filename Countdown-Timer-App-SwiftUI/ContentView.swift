//
//  ContentView.swift
//  Countdown-Timer-App-SwiftUI
//
//  Created by Jonas Bergström on 2022-09-26.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let width: Double = 300
    
    var body: some View {
        VStack {
            Text("\(viewModel.time)")
                .font(.system(size: 90, weight: .medium, design: .rounded))
                .padding()
                .frame(width: width)
                .background(.thinMaterial)
                .cornerRadius(20)
                .overlay(RoundedRectangle(cornerRadius: 50)
                    .stroke(Color.gray, lineWidth: 10))
                .alert("Timer is finish!", isPresented: $viewModel.showAlert) {
                    Button("Continue", role: .cancel) {
                        
                    }
                }
            Slider(value: $viewModel.minutes, in: 1...60, step: 1)
                .padding()
                .frame(width: width)
                .disabled(viewModel.isActive)
                .animation(.easeInOut, value: viewModel.minutes)
            
            HStack(spacing: 50) {
                Button("Start") {
                    viewModel.startTimer(minutes: viewModel.minutes)
                }
                .disabled(viewModel.isActive)
                
                Button("Reset", action: viewModel.resetTimer)
                    .tint(.red)
            }
            .frame(width: width)
        }
        .onReceive(timer) { _ in
            viewModel.updateTimer()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
