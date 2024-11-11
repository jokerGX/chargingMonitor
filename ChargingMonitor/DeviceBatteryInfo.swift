// DeviceBatteryInfo.swift

import Foundation
import FirebaseFirestore

struct DeviceBatteryInfo: Identifiable, Codable, Hashable {
    var id: String? // Firestore Document ID
    var deviceID: String
    var deviceName: String
    var timestamp: Date
    var batteryLevel: Float
    var isCharging: Bool
    var estimatedTimeToFull: String
    var thermalState: String
}
