//
//  AccountSettings.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 30.01.25.
//

import SwiftUI

struct AccountSettings: View {
    var body: some View {
        VStack(spacing: 0) {
            SectionHeader(title: "Account Settings")

            Group {
                SettingsRow(title: "My Account", systemImage: "person")
                Divider()
                SettingsRow(title: "My Orders", systemImage: "doc.plaintext")
                Divider()
                SettingsRow(title: "Preferences", systemImage: "gear")
                Divider()
                SettingsRow(title: "Permissions", systemImage: "eye")
                Divider()
                SettingsRow(title: "Support", systemImage: "questionmark.circle")
                Divider()
                SettingsRow(title: "Contact", systemImage: "phone")
            }
            .foregroundStyle(.secondary)
            .background(Color.white)
            .padding(5)
        }
        .padding(.horizontal)
    }
}

