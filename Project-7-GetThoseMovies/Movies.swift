//
//  File.swift
//  Project-7-GetThoseMovies
//
//  Created by suhail on 20/09/23.
//

import Foundation

struct Movies:Codable{
    
    var Search:[Search]
    
}

struct Search:Codable{
    var Title: String
    var Year : String
    var imdbID : String
    var `Type` :  String
    var Poster : String
    
//    private enum codingKeys: String,CodingKey{
//        case Title, Year , imdbID, _Type = "Type"
//    }
}
