// DeviceRowView.swift

import SwiftUI

struct DeviceRowView: View {
    var device: DeviceBatteryInfo

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(device.deviceName)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text("Battery: \(Int(device.batteryLevel * 100))%")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            // Charging Status Indicator
            HStack(spacing: 5) {
                Image(systemName: device.isCharging ? "bolt.fill" : "bolt.slash.fill")
                    .foregroundColor(device.isCharging ? .green : .red)

                Text(device.isCharging ? "Charging" : "Not Charging")
                    .font(.subheadline)
                    .foregroundColor(device.isCharging ? .green : .red)
            }
            .padding(.trailing, 10)

            // Thermal State Indicator
            HStack(spacing: 5) {
                Image(systemName: thermalStateIcon(state: device.thermalState))
                    .foregroundColor(thermalStateColor(state: device.thermalState))

                Text(device.thermalState.capitalized)
                    .font(.subheadline)
                    .foregroundColor(thermalStateColor(state: device.thermalState))
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(NSColor.windowBackgroundColor))
                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 2)
        )
    }

    // Helper Functions
    private func thermalStateIcon(state: String) -> String {
        switch state.lowercased() {
        case "nominal":
            return "thermometer"
        case "fair":
            return "thermometer.sun.fill"
        case "serious":
            return "thermometer.medium"
        case "critical":
            return "thermometer.snowflake"
        default:
            return "questionmark"
        }
    }

    private func thermalStateColor(state: String) -> Color {
        switch state.lowercased() {
        case "nominal":
            return .green
        case "fair":
            return .yellow
        case "serious":
            return .orange
        case "critical":
            return .red
        default:
            return .gray
        }
    }
}

struct DeviceRowView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceRowView(device: DeviceBatteryInfo(
            id: "123e4567-e89b-12d3-a456-426614174000",
            deviceID: "123e4567-e89b-12d3-a456-426614174000",
            deviceName: "GX",
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
