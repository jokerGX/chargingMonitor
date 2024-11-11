// DeviceDetailView.swift

import SwiftUI
import Charts

struct DeviceDetailView: View {
    var device: DeviceBatteryInfo

    // Placeholder data. Replace with actual historical data fetching.
    var dataPoints: [BatteryDataPoint] = [
        BatteryDataPoint(timestamp: Date().addingTimeInterval(-7200), batteryLevel: 0.5),
        BatteryDataPoint(timestamp: Date().addingTimeInterval(-3600), batteryLevel: 0.65),
        BatteryDataPoint(timestamp: Date(), batteryLevel: 0.75)
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Device Name
                Text(device.deviceName)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                // Battery and Estimated Time
                HStack(spacing: 20) {
                    BatteryProgressView(batteryLevel: device.batteryLevel, isCharging: device.isCharging)

                    VStack(alignment: .leading, spacing: 5) {
                        Text("Battery Level")
                            .font(.headline)
                        Text("\(Int(device.batteryLevel * 100))%")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }

                    VStack(alignment: .leading, spacing: 5) {
                        Text("Estimated Time to Full")
                            .font(.headline)
                        Text(device.estimatedTimeToFull)
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                }

                // Battery Level Chart
                BatteryLevelChartView(dataPoints: dataPoints)

                // Thermal State Visualization
                ThermalStateVisualization(state: device.thermalState)

                Spacer()
            }
            .padding()
        }
        .background(Color(NSColor.windowBackgroundColor))
        .animation(.easeInOut, value: device)
    }
}

struct DeviceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceDetailView(device: DeviceBatteryInfo(
            id: "123e4567-e89b-12d3-a456-426614174000",
            deviceID: "19C4F7F2-AA06-4298-93A5-18923643C766",
            deviceName: "iPhone",
            timestamp: Date(),
            batteryLevel: 0.85,
            isCharging: true,
            estimatedTimeToFull: "1h 30m",
            thermalState: "nominal"
        ))
    }
}
