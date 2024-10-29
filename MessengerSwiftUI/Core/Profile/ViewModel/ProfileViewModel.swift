//
//  ProfileViewModel.swift
//  MessengerSwiftUI
//
//  Created by serhat on 26.10.2024.
//

import SwiftUI
import PhotosUI

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published var selectedItem: PhotosPickerItem? {
        didSet { Task { try await loadImage() } }
    }
    
    @Published var profileImage: Image?
    
    
    /// Loads an image from the selected item, sets it as the profile image, and uploads it to Firebase.
    /// Attempts to retrieve and convert the selected item to `UIImage`, assigns it to `profileImage`,
    /// and uploads it to Firebase Storage. After uploading, updates the user's profile image URL in Firestore.
    /// - Throws: An error if loading or converting the image fails.
    func loadImage() async throws {
        guard let item = selectedItem else { return }
        guard let imageData = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: imageData) else { return }
        self.profileImage = Image(uiImage: uiImage)
        ImageUploaderService.uploadImage(image: uiImage) { imageUrl in
            UserService.shared.uploadProfileImageUrl(withImageUrl: imageUrl)
        }
    }
    
    
    /// Signs the user out and clears their session in `AuthService`.
    /// - Note: This action will set `userSession` to nil, effectively logging the user out of the app.
    func signOut(){
        AuthService.shared.signOut()
    }
    
}
