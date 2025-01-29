//
//  PersonalInfoView.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 29.01.25.
//

import SwiftUI

struct PersonalInfoView: View {
    @ObservedObject var profileManager: ProfileManager
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
                    .imageScale(.large)
            }
            .padding(.leading)

            Text("Personal information")
                .font(.largeTitle)
                .padding(.horizontal)

            VStack(alignment: .leading, spacing: 8) {
                Text("Full name")
                    .font(.callout)
                    .foregroundColor(.gray)

                TextField("Name", text: $profileManager.userName)
                    .font(.title3)
                
                Divider()
            }
            .padding(.horizontal)

            VStack(alignment: .leading, spacing: 8) {
                Text("Phone number")
                    .font(.callout)
                    .foregroundColor(.gray)

                TextField("Phone Number", text: $profileManager.userPhone)
                    .font(.title3)

                Divider()
            }
            .padding(.horizontal)

            VStack(alignment: .leading, spacing: 8) {
                Text("Email Address")
                    .font(.callout)
                    .foregroundColor(.gray)

                TextField("Email", text: $profileManager.userEmail)
                    .disabled(true)
                    .font(.title3)
                
                Divider()
            }
            .padding(.horizontal)

            VStack(alignment: .leading, spacing: 8) {
                Text("Address")
                    .font(.callout)
                    .foregroundColor(.gray)

                TextField("Address", text: $profileManager.userAddress)
                    .font(.title3)
                
                Divider()
            }
            .padding(.horizontal)
            
            Spacer()

            Button(action: {
                profileManager.updateUserProfile()
            }) {
                Text("Save Changes")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(16)
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding(.top)
        .background(Color.white)
        .navigationBarHidden(true)
    }
}
