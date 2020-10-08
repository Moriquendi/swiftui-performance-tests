//
//  Timeline.swift
//  SwiftUIPerformance
//
//  Created by Michał Śmiałko on 08/10/2020.
//

import SwiftUI

struct Timeline: View {

    let scale: Double
    private let minLongTickWidth = 30.0
    let LARGE_TICKS_COUNT = 50
    var SMALL_TICKS_COUNT = 5

    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            ForEach(ticks, id: \.self) { time in
                HStack(alignment: .bottom, spacing: 0) {
                    LongTick(text: "X")
                        .frame(width: smallTickWidth, alignment: .leading)

                    ForEach(1..<SMALL_TICKS_COUNT, id: \.self) { time in
                        SmallTick()
                            .frame(width: smallTickWidth, alignment: .leading)
                    }
                }
                .frame(width: longTickWidth, alignment: .leading)
            }
        }
        .background(Color(NSColor.black))
        .drawingGroup()
    }

    var oneLongTickDurationInMs: Double {
        let pointsForOneMilisecond = scale / 1000

        var msJump = 1
        var oneLongTickDurationInMs = 1.0
        while true {
            let longTickIntervalWidth = oneLongTickDurationInMs * pointsForOneMilisecond
            if longTickIntervalWidth >= minLongTickWidth {
                break
            }

            oneLongTickDurationInMs += Double(msJump)

            switch oneLongTickDurationInMs {
            case 0..<10: msJump = 1
            case 10..<100: msJump = 10
            case 100..<1000: msJump = 100
            case 1000..<10000: msJump = 1000
            default: msJump = 10000
            }
        }
        return oneLongTickDurationInMs
    }

    var longTickWidth: CGFloat {
        CGFloat(oneLongTickDurationInMs / 1000 * scale)
    }

    var ticks: [Double] {
        let oneLongTickDurationInMs = self.oneLongTickDurationInMs
        let tickTimesInMs = (0...LARGE_TICKS_COUNT).map { Double($0) * oneLongTickDurationInMs }
        return tickTimesInMs
    }

    var smallTickWidth: CGFloat {
        longTickWidth / CGFloat(SMALL_TICKS_COUNT)
    }
}

struct SmallTick: View {
    var body: some View {
        Rectangle()
            .fill(Color.blue)
            .frame(width: 1)
            .frame(maxHeight: 8)
    }
}


struct LongTick: View {

    let text: String

    var body: some View {
        Rectangle()
            .fill(Color.red)
            .frame(width: 1)
            .frame(maxHeight: .infinity)
            .overlay(
                Text(text)
                    .font(.system(size: 12))
                    .fixedSize()
                    .offset(x: 3, y: 0)
                ,
                alignment: .topLeading
            )
    }
}

struct Timeline_Previews: PreviewProvider {
    static var previews: some View {
        return Timeline(scale: 10)
            .frame(width: 300, height: 230)
    }
}
