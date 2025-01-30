//
//  ProfileElements.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 30.01.25.
//

import SwiftUI

struct SectionHeader: View {
    var title: String

    var body: some View {
        Text(title)
            .font(.headline)
            .fontWeight(.semibold)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 5)
    }
}

struct SettingsRow: View {
    var title: String
    var systemImage: String

    var body: some View {
        HStack {
            Image(systemName: systemImage)
                .foregroundColor(.black)
            Text(title)
                .foregroundColor(.black)
            Spacer()
            Image(systemName: "chevron.forward")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
    }
}
