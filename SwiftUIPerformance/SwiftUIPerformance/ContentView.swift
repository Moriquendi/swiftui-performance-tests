//
//  ContentView.swift
//  SwiftUIPerformance
//
//  Created by Michał Śmiałko on 08/10/2020.
//

import SwiftUI

struct ContentView: View {

    @State private var showTimeline: Bool = true
    @State private var scale: Double = 10.0

    var body: some View {
        VStack(alignment: .leading) {
            Button("Show/Hide Timeline") {
                showTimeline.toggle()
            }

            Slider(value: $scale, in: 1...100)

            if showTimeline {
                Timeline(scale: scale)
                    .frame(width: 300, height: 30, alignment: .leading)
            }
        }
        .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
