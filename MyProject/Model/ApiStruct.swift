//
//  ApiStruct.swift
//  MyProject
//
//  Created by user199453 on 7/3/21.
//

import Foundation

struct ProjectData: Codable {
    var total_count : Int?
    var incomplete_results : Bool?
    var items: [Item]
    
}

struct Item: Codable {
    
    var full_name: String?
    var owner: Owner?
    var html_url: String?
    var description: String?

}
struct Owner: Codable {
    var login: String?
    var avatar_url: String?
}
