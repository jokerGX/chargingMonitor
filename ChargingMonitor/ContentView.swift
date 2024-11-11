// ContentView.swift

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = BatteryDataViewModel()
    @State private var selectedDevice: DeviceBatteryInfo?
    @State private var searchText: String = ""

    var filteredDevices: [DeviceBatteryInfo] {
        if searchText.isEmpty {
            return viewModel.devices
        } else {
            return viewModel.devices.filter { $0.deviceName.lowercased().contains(searchText.lowercased()) }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                TextField("Search Devices", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.horizontal, .top])

                // Device List
                List(selection: $selectedDevice) {
                    ForEach(filteredDevices) { device in
                        DeviceRowView(device: device)
                            .tag(device)
                    }
                }
                .listStyle(SidebarListStyle())
            }
            .frame(minWidth: 250)
            .navigationTitle("Devices")
            .toolbar {
                ToolbarItemGroup(placement: .automatic) {
                    // Refresh Button
                    HoverButton(action: {
                        viewModel.fetchData()
                    }, imageName: "arrow.clockwise")
                    .foregroundColor(.blue)
                    .disabled(viewModel.isRefreshing)

                    // Add Device Button
                    HoverButton(action: {
                        // Implement add device functionality if needed
                        // For example, present a sheet to add a new device
                    }, imageName: "plus")
                    .foregroundColor(.green)
                }
            }

            // Detail View
            if let device = selectedDevice {
                DeviceDetailView(device: device)
            } else {
                VStack {
                    Image(systemName: "tray")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.secondary)
                        .padding()

                    Text("Select a device to see details")
                        .font(.title)
                        .foregroundColor(.secondary)
                }
                .transition(.opacity)
            }
        }
        .frame(minWidth: 900, minHeight: 600)
        .onAppear {
            if let firstDevice = viewModel.devices.first {
                selectedDevice = firstDevice
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
