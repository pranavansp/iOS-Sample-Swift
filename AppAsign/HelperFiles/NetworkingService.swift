//
//  NetworkingService.swift
//  AppAsign
//
//  Created by Pranavan on 7/14/18.
//  Copyright © 2018 Pranavan. All rights reserved.
//

import Foundation
import Alamofire

class NetworkingService {
    
    static let shared = NetworkingService()
    private init() {}
    
    var BASE_URL = "https://newsapi.org/v2/"
    
    //MARK: - GET Common Network Request true/false
    func getFrom(url:String, completion: @escaping(Data,Bool)->Void){
        
        let fullURL = "\(BASE_URL)\(url)"
        
        Alamofire.request(fullURL,method: .get, encoding: JSONEncoding.default).validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"]).responseJSON { response in
                let checkServerMsg = String.init(data: response.data!, encoding: String.Encoding.utf8)
                var serverMessage = "0"
                if let serverReturnMessage = checkServerMsg{
                    serverMessage = serverReturnMessage
                }
                if let rawData = response.data{
                    print("Server Return: \(rawData))")
                    completion(rawData,true)
                }else{
                    print("Faild")
                    completion((serverMessage as AnyObject) as! Data,false)
                }
        }
    }
}
