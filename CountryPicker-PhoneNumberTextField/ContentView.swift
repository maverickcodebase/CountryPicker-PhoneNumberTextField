//
//  ContentView.swift
//  CountryPicker-PhoneNumberTextField
//
//  Created by Maverick Codebase on 25/02/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State var phoneNumber: String = ""
    
    var body: some View {
        VStack {
            Image(.logo)
                .resizable()
                .frame(width: 250, height: 150)
           
            
            TextFieldPhoneNumber(text: $phoneNumber)
            
            Spacer()
           
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
