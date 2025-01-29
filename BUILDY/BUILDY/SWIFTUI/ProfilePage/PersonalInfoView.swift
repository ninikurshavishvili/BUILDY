//
//  PersonalInfoView.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 29.01.25.
//

import SwiftUI

struct PersonalInfoView: View {
    @ObservedObject var profileManager: ProfileManager

    var body: some View {
        Form {
            Section(header: Text("Personal Info")) {
                TextField("Name", text: $profileManager.userName)
                TextField("Email", text: $profileManager.userEmail)
                    .disabled(true)
                TextField("Phone Number", text: $profileManager.userPhone)
                TextField("Address", text: $profileManager.userAddress)
            }

            Section {
                Button("Save Changes") {
                    profileManager.updateUserProfile()
                }
            }

        }
        .navigationTitle("Personal Info")
        .background(Color.white)
    }
}
