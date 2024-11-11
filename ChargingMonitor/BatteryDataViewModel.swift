// BatteryDataViewModel.swift

import Foundation
import FirebaseFirestore
import Combine

class BatteryDataViewModel: ObservableObject {
    @Published var devices: [DeviceBatteryInfo] = []
    @Published var errorMessage: String? = nil
    @Published var isRefreshing: Bool = false

    private var db = Firestore.firestore()
    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchData()
    }

    func fetchData() {
        isRefreshing = true
        db.collection("batteryData")
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { [weak self] (querySnapshot, error) in
                guard let self = self else { return }
                self.isRefreshing = false

                if let error = error {
                    DispatchQueue.main.async {
                        self.errorMessage = "Failed to fetch data: \(error.localizedDescription)"
                    }
                    print("Error fetching data: \(error.localizedDescription)")
                    return
                }

                guard let documents = querySnapshot?.documents else {
                    DispatchQueue.main.async {
                        self.errorMessage = "No documents found."
                    }
                    print("No documents found")
                    return
                }

                self.devices = documents.compactMap { document in
                    let data = document.data()
                    return self.decodeDeviceBatteryInfo(from: data, documentID: document.documentID)
                }

                DispatchQueue.main.async {
                    self.errorMessage = nil // Clear any previous error messages
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
            let timestamp = data["timestamp"] as? Timestamp
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
