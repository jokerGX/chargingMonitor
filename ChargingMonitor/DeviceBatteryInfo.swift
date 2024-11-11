// DeviceBatteryInfo.swift

import Foundation

struct DeviceBatteryInfo: Identifiable, Codable {
    var id: String? // Firestore document ID
    var deviceID: String
    var deviceName: String
    var timestamp: Date
    var batteryLevel: Float
    var isCharging: Bool
    var estimatedTimeToFull: String
    var thermalState: String
}
