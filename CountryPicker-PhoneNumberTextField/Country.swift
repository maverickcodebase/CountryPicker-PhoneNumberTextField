//
//  Country.swift
//  CountryPicker-PhoneNumberTextField
//
//  Created by Sheraz Ahmed on 26/02/2025.
//

import Foundation

struct Country: Codable, Hashable {
    var name: String
    var dialCode: String
    var isoCode: String
    var flag: String{
        isoCode.unicodeScalars.reduce(into: ""){
            if let scalar = UnicodeScalar(127397 + $1.value){
                $0.unicodeScalars.append(scalar)
            }
        }
    }
    
    
    static let list: [Country] = {
        guard let url = Bundle.main.url(forResource: "countries", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              var countries = try? JSONDecoder().decode([Country].self, from: data)
        else {
            return []
        }
        
        
        if let userRegionCode = Locale.current.region?.identifier,
           let index = countries.firstIndex(where: { $0.isoCode == userRegionCode}){
            
            let userCountry = countries.remove(at: index)
            countries.insert(userCountry, at: 0)
        }
        
        return countries
                
    }()
}
