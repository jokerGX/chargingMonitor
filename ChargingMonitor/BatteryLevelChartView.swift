// BatteryLevelChartView.swift

import SwiftUI
import Charts

struct BatteryLevelChartView: View {
    var dataPoints: [BatteryDataPoint]

    var body: some View {
        Chart {
            ForEach(dataPoints) { point in
                LineMark(
                    x: .value("Time", point.timestamp),
                    y: .value("Battery Level", point.batteryLevel)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(Color.blue.gradient)
            }
        }
        .chartXAxis {
            AxisMarks(format: .dateTime.hour().minute())
        }
        .chartYAxis {
            AxisMarks(position: .leading) {
//                AxisValueLabel(format: .number.precision(.fractionLength(0)))
                AxisGridLine()
            }
        }
        .padding()
        .frame(height: 200)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(NSColor.windowBackgroundColor))
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
//        .animation(.easeInOut, value: dataPoints)
    }
}

struct BatteryLevelChartView_Previews: PreviewProvider {
    static var previews: some View {
        BatteryLevelChartView(dataPoints: [
            BatteryDataPoint(timestamp: Date().addingTimeInterval(-7200), batteryLevel: 0.5),
            BatteryDataPoint(timestamp: Date().addingTimeInterval(-3600), batteryLevel: 0.65),
            BatteryDataPoint(timestamp: Date(), batteryLevel: 0.75)
        ])
        .previewLayout(.sizeThatFits)
        .padding()
    }
}

struct BatteryDataPoint: Identifiable {
    let id = UUID()
    let timestamp: Date
    let batteryLevel: Float
}
