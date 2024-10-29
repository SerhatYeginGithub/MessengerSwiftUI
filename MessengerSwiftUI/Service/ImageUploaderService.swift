//
//  ImageUploaderService.swift
//  MessengerSwiftUI
//
//  Created by serhat on 29.10.2024.
//

import Foundation
import FirebaseStorage
import FirebaseAuth
import UIKit

final class ImageUploaderService {
    
    
    /// Uploads a profile image to Firebase Storage for the current user.
    /// - Parameters:
    ///   - image: The UIImage to be uploaded.
    ///   - completion: A closure that provides the download URL of the uploaded image as a String.
    /// - Note: Compresses the image to 50% quality before uploading. Saves the image to a path based on the user's unique ID and returns the download URL upon success.
    static func uploadImage(image: UIImage,completion: @escaping(String)-> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        let ref = Storage.storage().reference(withPath: "/profile_images/\(uid)")
        ref.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("DEBUG: Failed to upload image \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { url, _ in
                guard let imageUrl = url?.absoluteString else { return }
                completion(imageUrl)
            }
            
        }
    }
    
}
