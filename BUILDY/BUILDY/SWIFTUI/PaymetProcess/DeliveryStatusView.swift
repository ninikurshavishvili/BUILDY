//
//  DeliveryStatusView.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 24.01.25.
//

import SwiftUI

struct DeliveryStatusView: View {
    var body: some View {
        VStack {
            MapView()
                .frame(height: 300)
            
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Estimated Time:")
                        .font(.headline)
                    Spacer()
                    Text("9:00 PM")
                        .font(.subheadline)
                }
                
                HStack {
                    Image("driver_image") 
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text("Driver: George")
                            .font(.headline)
                        Text("⭐️⭐️⭐️⭐️")
                            .font(.subheadline)
                    }
                    Spacer()
                }
                
                Text("Track Your Order")
                    .font(.headline)
                
                Spacer()
                
                Button(action: {
                    print("Order canceled")
                }) {
                    Text("Cancel Order")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationTitle("Delivery Status")
    }
}

struct MapView: View {
    var body: some View {
        Color.gray
    }
}


