//
//  TextFieldPhoneNumber.swift
//  CountryPicker-PhoneNumberTextField
//
//  Created by Sheraz Ahmed on 26/02/2025.
//

import SwiftUI

struct TextFieldPhoneNumber: View {
    
    @Binding var text: String
    @State private var phoneNumber: String = ""
    @FocusState private var isFocused: Bool
    @State private var showModel: Bool = false
    
    
    @State private var selectedCountry: Country = Country.list.first!
    @State private var searchText: String = ""
    
    
    var filteredCountries: [Country] {
        searchText.isEmpty ? Country.list :
        Country.list.filter {
            $0.name.lowercased().contains(searchText.lowercased()) ||
            $0.dialCode.lowercased().contains(searchText)
        }
    }
    var body: some View {
        
        inputField
            .sheet(isPresented: $showModel) {
                countrySelectionSheet
            }
            .onChange(of: selectedCountry) {
                updatePhoneNumber()
            }
            .onChange(of: phoneNumber) {
                updatePhoneNumber()
            }
            .onAppear{
                updatePhoneNumber()
            }
    }
    
    
    private var inputField: some View{
        HStack{
            Button {
                self.showModel.toggle()
            } label: {
                
                Text("\(selectedCountry.flag) (\(selectedCountry.dialCode))")
                    .foregroundStyle(Color(.label))
                
                Image(systemName: "minus")
                    .rotationEffect(.degrees(90))
                    .foregroundStyle(Color.gray)
                
            }
            
            
            TextField("Phone Number", text: $phoneNumber)
                .keyboardType(.phonePad)
                .frame(height: 22)
                .focused($isFocused)
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(isFocused ? Color.blue : Color.gray ,lineWidth: 1)
        }
    }
    
    private var countrySelectionSheet: some View {
        NavigationStack{
            List(filteredCountries, id: \.self){item in
                
                GroupBox{
                    HStack {
                        Text("\(item.flag)")
                        Text("\(item.name)")
                        Spacer()
                        Text("\(item.dialCode)")
                            .foregroundStyle(Color(.secondaryLabel))
                    }
                }
                .listRowSeparator(.hidden)
                .backgroundStyle(item == selectedCountry ? Color.accentColor.opacity(0.1) : Color(.systemBackground))
                .shadow(color: Color(.black).opacity(0.1), radius: 2, x: 0, y: 1)
                .onTapGesture {
                    selectedCountry = item
                    showModel = false
                }
                
            }
            .listStyle(.plain)
            .searchable(text: $searchText, prompt: "Search Countries or Code")
            .navigationTitle("Choose Country Code")
        }
    }
    
    
    private func updatePhoneNumber() {
        text = "\(selectedCountry.dialCode)\(phoneNumber)"
    }
}

#Preview {
    @Previewable @State var text = ""
    TextFieldPhoneNumber(text: $text)
        .padding()
}
