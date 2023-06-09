import SwiftUI

@main
struct iOSApp: App {
    private var service = PhotosService(baseURL: URL(string: "https://island-bramble.glitch.me/orders")!)

	var body: some Scene {
		WindowGroup {
			ContentView().environmentObject(PhotoModel(photosService: service))

		}
	}
}
