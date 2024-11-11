// BatteryProgressView.swift

import SwiftUI

struct BatteryProgressView: View {
    var batteryLevel: Float
    var isCharging: Bool

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 8)
                .opacity(0.3)
                .foregroundColor(isCharging ? Color.green.opacity(0.3) : Color.orange.opacity(0.3))

            Circle()
                .trim(from: 0.0, to: CGFloat(min(batteryLevel, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
                .foregroundColor(isCharging ? .green : .orange)
                .rotationEffect(Angle(degrees: -90))
                .animation(.linear(duration: 1.0), value: batteryLevel)

            Text("\(Int(batteryLevel * 100))%")
                .font(.caption)
                .bold()
                .foregroundColor(.primary)
        }
        .frame(width: 50, height: 50)
    }
}

struct BatteryProgressView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BatteryProgressView(batteryLevel: 0.75, isCharging: true)
                .preferredColorScheme(.light)

            BatteryProgressView(batteryLevel: 0.75, isCharging: false)
                .preferredColorScheme(.dark)
        }
    }
}
