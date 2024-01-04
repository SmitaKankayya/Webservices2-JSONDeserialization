//
//  Data.swift
//  Webservices2-JSON_Deserialization
//
//  Created by Smita Kankayya on 02/01/24.
//

import Foundation

struct User : Decodable{
    var data : [Data]
}

struct Data: Decodable{
    var id : Int
    var first_name : String
    var avatar : String
}
