// ContentView.swift

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = BatteryDataViewModel()
    @State private var selectedDevice: DeviceBatteryInfo?

    var body: some View {
        NavigationView {
            List(viewModel.devices) { device in
                DeviceRowView(device: device)
                    .onTapGesture {
                        selectedDevice = device
                    }
            }
            .navigationTitle("Charging Monitor")
            .listStyle(SidebarListStyle())

            if let device = selectedDevice {
                DeviceDetailView(device: device)
            } else {
                Text("Select a device to see details")
                    .font(.title)
                    .foregroundColor(.secondary)
            }
        }
        .frame(minWidth: 900, minHeight: 600)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
