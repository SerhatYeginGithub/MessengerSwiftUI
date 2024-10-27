//
//  ProfileViewModel.swift
//  MessengerSwiftUI
//
//  Created by serhat on 26.10.2024.
//

import SwiftUI
import PhotosUI

final class ProfileViewModel: ObservableObject {
    @Published var selectedItem: PhotosPickerItem? {
        didSet { Task { try await loadImage() } }
    }
    
    @Published var profileImage: Image?
    
    
    /// Asynchronously loads an image from `selectedItem` and assigns it to `profileImage`.
    ///
    /// Checks if an item is selected, loads its image data, converts it to `UIImage`,
    /// and wraps it in a SwiftUI `Image`.
    ///
    /// - Throws: An error if image data can't be loaded or `UIImage` creation fails.
    func loadImage() async throws {
        guard let item = selectedItem else { return }
        guard let imageData = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: imageData) else { return }
        self.profileImage = Image(uiImage: uiImage)
    }
    
}
