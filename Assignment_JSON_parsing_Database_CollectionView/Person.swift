//
//  Person.swift
//  Assignment_JSON_parsing_Database_CollectionView
//
//  Created by Mac on 15/01/24.
//

import Foundation
struct Person{
    var id : Int
    var name : String
    var username : String
    var email : String
    var address : Address
    var phone : String
    var website : String
    var company : Company
}
struct Address{
    var street : String
    var suite : String
    var city : String
    var zipcode : String
    var geo : Geo
}
struct Geo
{
    var lat : String
    var lng : String
}
struct Company
{
    var name : String
    var catchPhrase : String
    var bs : String
}
