//
//  File.swift
//  AppAsign
//
//  Created by Pranavan on 7/14/18.
//  Copyright © 2018 Pranavan. All rights reserved.
//

import Foundation

//MARK:- Full Response
struct REST : Decodable {
    var articles : [Article]?
    var status : String?
    var totalResults : Int?
}

//MARK:- Articles
struct Article: Decodable{
    let author:String?
    let title:String?
    let desc:String?
    let url:String?
    let urlToImage:String?
    let publishedAt:String?
    let source:Source?
}

//MARK:- Source
struct Source: Decodable {
    let id : String?
    let name : String?
}
