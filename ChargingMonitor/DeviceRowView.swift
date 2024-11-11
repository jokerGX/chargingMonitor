// DeviceRowView.swift

import SwiftUI

struct DeviceRowView: View {
    var device: DeviceBatteryInfo

    var body: some View {
        HStack(spacing: 20) {
            BatteryProgressView(batteryLevel: device.batteryLevel, isCharging: device.isCharging)

            VStack(alignment: .leading, spacing: 5) {
                Text(device.deviceName)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text("Battery Level: \(Int(device.batteryLevel * 100))%")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            // Charging Status Indicator with Animation
            HStack(spacing: 5) {
                Image(systemName: device.isCharging ? "bolt.fill" : "bolt.slash.fill")
                    .foregroundColor(device.isCharging ? .green : .red)
                    .scaleEffect(device.isCharging ? 1.2 : 1.0)
                    .animation(.easeInOut(duration: 0.3), value: device.isCharging)

                Text(device.isCharging ? "Charging" : "Not Charging")
                    .font(.subheadline)
                    .foregroundColor(device.isCharging ? .green : .red)
                    .transition(.opacity)
            }

            // Thermal State Badge
            ThermalStateBadge(state: device.thermalState)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(NSColor.windowBackgroundColor))
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
        .padding(.horizontal)
        .animation(.easeInOut, value: device.batteryLevel)
    }
}

struct DeviceRowView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceRowView(device: DeviceBatteryInfo(
            id: "123e4567-e89b-12d3-a456-426614174000",
            deviceID: "19C4F7F2-AA06-4298-93A5-18923643C766",
            deviceName: "iPhone",
            timestamp: Date(),
            batteryLevel: 0.85,
            isCharging: true,
            estimatedTimeToFull: "1h 30m",
            thermalState: "nominal"
        ))
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
