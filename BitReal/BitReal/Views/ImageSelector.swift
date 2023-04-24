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
    @State private var showAlert = false
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var showImagePlaceholder = true
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showCameraPicker = false

    
    var isNewAccount: Bool
    
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
            Button(action: {
                showCameraPicker = true
            }) {
                Text("Take a Photo")
                    .foregroundColor(.white)
                    .frame(width: 180, height: 50)
                    .background(Color("Purple"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .sheet(isPresented: $showCameraPicker) {
                ImagePicker(sourceType: .camera) { image in
                    // Use the selected image as the profile picture
                    if isNewAccount {
                        authViewModel.uploadProfileImage(image)
                    } else {
                        authViewModel.updateProfileImage(image) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }

            Button {
                if (selectedImageData == nil) {
                    if (randomSelected) {
                        // choose a random image for user
                        let randomImageNumber = arc4random_uniform(17) // Generate a random number between 0 and 16
                        let imageName = "pic\(randomImageNumber)"
                        if let image = UIImage(named: imageName) {
                            if isNewAccount {
                                authViewModel.uploadProfileImage(image)
                            } else {
                                authViewModel.updateProfileImage(image) {
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                            
                        }
                    } else {
                        // alert user to select photo or toggle random image selection
                        showAlert = true
                    }
                } else {
                    // upload selectedImageData
                    if let selectedImageData,
                       let uiImage = UIImage(data: selectedImageData) {
                        print("Uploading image")
                        if isNewAccount {
                            authViewModel.uploadProfileImage(uiImage)
                        } else {
                            print("inside custom image for existing user")
                            authViewModel.updateProfileImage(uiImage) {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }
                }
                print("DEBUG: upload photo image")
            } label: {
                Text(isNewAccount ? "Create Account" : "Change Picture")
                    .foregroundColor(.white)
                    .frame(width: 180, height: 50)
                    .background(Color("Purple"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Select a Photo"),
                      message: Text("Please select a photo or take a picture for your profile or toggle random selection."),
                      dismissButton: .default(Text("OK")))
            }
            
            Spacer()
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton(color: .white) {
            self.presentationMode.wrappedValue.dismiss()
        })
    }
}

struct ImageSelector_Previews: PreviewProvider {
    static var previews: some View {
        ImageSelector(isNewAccount: true)
    }
}
