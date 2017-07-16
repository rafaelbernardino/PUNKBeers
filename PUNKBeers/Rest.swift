//
//  Rest.swift
//  PUNKBeers
//
//  Created by Rafael Bernardino on 16/07/17.
//  Copyright © 2017 Rafael Bernardino. All rights reserved.
//
import UIKit
import Foundation

class Rest {
    static let basePath = "https://api.punkapi.com/v2/beers"
    
    static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = false
        config.httpAdditionalHeaders = ["Content-Type":"application/json"]
        config.timeoutIntervalForRequest = 20.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    
    static let session = URLSession(configuration: configuration)
    
    static func loadBeer(onComplete: @escaping ([Beer]?) -> Void){
        guard let url = URL(string: basePath) else {
            onComplete(nil)
            return
        }
        
        session.dataTask(with: url) {(data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                onComplete(nil)
            } else {
                guard let response = response as? HTTPURLResponse else {
                    onComplete(nil)
                    return
                }
                
                if response.statusCode == 200 {
                    guard let data = data else {
                        onComplete(nil)
                        return
                    }
                    
                    let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! [[String: Any]]
                    
                    var beers:[Beer] = []
                    for item in json {
                        let name = item["name"] as! String
                        let tagline = item["tagline"] as! String
                        let description = item["description"] as! String
                        let abv = item["abv"] as! Double
                        let ibu = item["ibu"] as? Int == nil ? 0 : item["ibu"] as! Int
                        let image = item["image_url"] as! String
                        let id = item["id"] as! Int
                        
                        let beer = Beer(name: name, tagline: tagline, description: description, image: image, abv: abv, ibu:ibu )
                        beer.id = id
                        beers.append(beer)
                    }
                    onComplete(beers)
                    
                } else {
                    onComplete(nil)
                }
            }
            }.resume()
    }
    
    static func downloadImage(url: String, onComplete: @escaping (UIImage?) -> Void){
        guard let url = URL(string: url) else{
            onComplete(nil)
            return
        }
        
        session.downloadTask(with: url, completionHandler: { (url: URL?, response: URLResponse?, error: Error?) in
            if let response = response as? HTTPURLResponse, response.statusCode == 200, let url = url {
                let imageData = try! Data(contentsOf: url)
                let image = UIImage(data: imageData)
                onComplete(image)
            } else {
                onComplete(nil)
            }
        }).resume()
    }
}
