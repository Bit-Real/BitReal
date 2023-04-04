//
//  ImageSelector.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 4/3/23.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseAuth

struct ImageSelector: View {

    @State private var randomSelected = false
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
//    @State private var uiImage: UIImage?
    @State private var showImagePlaceholder = true
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack { Spacer() }
                
                Text("Select a profile")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                Text("picture...")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
            .frame(height: 260)
            .padding(.leading)
            .background(Color("Purple"))
            .foregroundColor(.white)
            .clipShape(RoundedShape(corners: [.bottomRight]))
            
            PhotosPicker(
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()) {
                        if self.showImagePlaceholder {
                            Circle()
                                .stroke(style: StrokeStyle(lineWidth: 3, dash: [12]))
                                .frame(width: 250, height: 250)
                                .foregroundColor(Color("Purple"))
                                .overlay(
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .foregroundColor(Color("Purple"))
                                )
                                .padding(.top, 50)
                        } else {
                            if let selectedImageData,
                               let uiImage = UIImage(data: selectedImageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 250, height: 250)
                                    .clipShape(Circle())
                                    .padding()
                            }
                        }
                    }
                    .onChange(of: selectedItem) { newItem in
                        Task {
                            // Retrive selected asset in the form of Data
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                self.selectedImageData = data
                                self.showImagePlaceholder = false
                            }
                        }
                    }
            
            Toggle("Select a photo for me", isOn: $randomSelected)
                .toggleStyle(SwitchToggleStyle(tint: Color(.systemPurple)))
                .padding()
                .padding(.top, 30)
            
            Button {
                if (selectedImageData == nil) {
                    if (randomSelected) {
                        // choose a random image for user
                    } else {
                        // alert user to select photo
                    }
                } else {
                    // upload selectedImageData
                    if let selectedImageData,
                       let uiImage = UIImage(data: selectedImageData) {
                        print("Uploading image")
                        authViewModel.uploadProfileImage(uiImage)
                    }
                }
                print("DEBUG: upload photo image")
            } label: {
                Text("Create Account")
                    .foregroundColor(.white)
                    .frame(width: 180, height: 50)
                    .background(Color("Purple"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            Spacer()
        }
        .ignoresSafeArea()
    }
}

struct ImageSelector_Previews: PreviewProvider {
    static var previews: some View {
        ImageSelector()
    }
}
