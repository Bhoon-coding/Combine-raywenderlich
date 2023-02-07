
import SwiftUI
import Combine

@main
struct HNReader: App {
    let viewModel = ReaderViewModel()
    
    var body: some Scene {
        WindowGroup {
            ReaderView(model: viewModel)
                .onAppear {
                    viewModel.fetchStroies()
                }
        }
    }
}
