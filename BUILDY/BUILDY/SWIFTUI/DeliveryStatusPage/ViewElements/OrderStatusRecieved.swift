//
//  OrderStatusRecieved.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 30.01.25.
//


import SwiftUI


struct OrderStatusRecieved: View {
    var status: String
    var icon: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.customOrange)
            Text(status)
                .font(.title2)
                .fontWeight(.medium)
        }
    }
}

struct OrderStatus: View {
    var status: String
    var icon: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.gray)
            Text(status)
                .font(.title2)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
        }
    }
}


