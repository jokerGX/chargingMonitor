// DeviceDetailView.swift

import SwiftUI

struct DeviceDetailView: View {
    var device: DeviceBatteryInfo

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(device.deviceName)
                .font(.largeTitle)
                .fontWeight(.bold)

            HStack {
                Image(systemName: device.isCharging ? "bolt.fill" : "bolt.slash.fill")
                    .foregroundColor(device.isCharging ? .green : .red)
                Text(device.isCharging ? "Charging" : "Not Charging")
                    .font(.title2)
                    .foregroundColor(device.isCharging ? .green : .red)
            }

            HStack {
                Image(systemName: "battery.100")
                    .foregroundColor(.blue)
                Text("Battery Level: \(Int(device.batteryLevel * 100))%")
                    .font(.title2)
                    .foregroundColor(.blue)
            }

            HStack {
                Image(systemName: thermalStateIcon(state: device.thermalState))
                    .foregroundColor(thermalStateColor(state: device.thermalState))

                Text("Thermal State: \(device.thermalState.capitalized)")
                    .font(.title2)
                    .foregroundColor(thermalStateColor(state: device.thermalState))
            }

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color(NSColor.windowBackgroundColor))
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

struct DeviceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceDetailView(device: DeviceBatteryInfo(
            id: "123e4567-e89b-12d3-a456-426614174000",
            deviceID: "123e4567-e89b-12d3-a456-426614174000",
            deviceName: "GX",
            timestamp: Date(),
            batteryLevel: 0.85,
            isCharging: true,
            estimatedTimeToFull: "1h 30m",
            thermalState: "nominal"
        ))
    }
}
