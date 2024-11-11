// BatteryDataViewModel.swift

import Foundation
import FirebaseFirestore
import Combine

class BatteryDataViewModel: ObservableObject {
    @Published var devices: [DeviceBatteryInfo] = []
    private var db = Firestore.firestore()
    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchData()
    }

    func fetchData() {
        db.collection("batteryData")
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { [weak self] (querySnapshot, error) in
                if let error = error {
                    print("Error fetching data: \(error.localizedDescription)")
                    return
                }

                guard let documents = querySnapshot?.documents else {
                    print("No documents found")
                    return
                }

                self?.devices = documents.compactMap { document in
                    // Manually decode each document into DeviceBatteryInfo
                    let data = document.data()
                    return self?.decodeDeviceBatteryInfo(from: data, documentID: document.documentID)
                }
            }
    }

    private func decodeDeviceBatteryInfo(from data: [String: Any], documentID: String) -> DeviceBatteryInfo? {
        guard
            let deviceID = data["deviceID"] as? String,
            let deviceName = data["deviceName"] as? String,
            let batteryLevel = data["batteryLevel"] as? Float,
            let isCharging = data["isCharging"] as? Bool,
            let estimatedTimeToFull = data["estimatedTimeToFull"] as? String,
            let thermalState = data["thermalState"] as? String,
            let timestamp = data["timestamp"] as? Timestamp // Firestore Timestamp
        else {
            print("Error: Missing or invalid fields in document \(documentID)")
            return nil
        }

        let date = timestamp.dateValue()

        return DeviceBatteryInfo(
            id: documentID,
            deviceID: deviceID,
            deviceName: deviceName,
            timestamp: date,
            batteryLevel: batteryLevel,
            isCharging: isCharging,
            estimatedTimeToFull: estimatedTimeToFull,
            thermalState: thermalState
        )
    }
}
