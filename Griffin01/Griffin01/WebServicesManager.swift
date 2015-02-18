//
//  WebServicesManager.swift
//  Griffin01
//
//  Created by Shawn Seals on 1/26/15.
//  Copyright (c) 2015 Shawn Seals. All rights reserved.
//

import UIKit

class WebServicesManager: NSObject {
   
    
    // MARK: - Singleton
    
    class var sharedInstance: WebServicesManager {
        struct Singleton {
            static let instance = WebServicesManager()
        }
        return Singleton.instance
    }
    
    
    //MARK: - Main Methods
    
    func downloadItunesItemsMatchingSearchTerm(searchTerm: String, withCompletion completion: ((itunesItems: [ItunesItem], success: Bool) -> Void)?) {
    
        let url = NSURL(string: urlStringForItunesSearchString(searchTerm))
        
        let dataTask = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
            
            var itunesItems = [ItunesItem]()
            
            if error == nil {
                
                //let rawStringData: String = NSString(data: data, encoding: NSUTF8StringEncoding)!
                //println("WebServicesManager downloadItunesItemsMatchingSearchTerm rawStringData:\n\(rawStringData)")
                
                let httpResponse = response as NSHTTPURLResponse
                
                if httpResponse.statusCode == 200 {
                    
                    itunesItems = self.itunesItemsFromData(data)
                    
                    if completion != nil {
                        completion!(itunesItems: itunesItems, success: true)
                    }
                    
                } else {
                    println("Unable To Download iTunes Data. HTTP Response Status Code: \(httpResponse.statusCode)")
                    if completion != nil {
                        completion!(itunesItems: itunesItems, success: false)
                    }
                }
            } else {
                println("Unable To Download iTunes Data. Connection Error: \(error.localizedDescription)")
                if completion != nil {
                    completion!(itunesItems: itunesItems, success: false)
                }
            }
        })
        
        dataTask.resume()
    }
    
    func downloadImageFromUrl(urlString: String, withCompletion completion: ((image: UIImage?, success: Bool) -> Void)?) {
        
        let url = NSURL(string: urlString)
        
        let dataTask = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
            
            if error == nil {
                
                let httpResponse = response as NSHTTPURLResponse
                
                if httpResponse.statusCode == 200 {
                    
                    if let image = UIImage(data: data) {
                                                
                        if completion != nil {
                            completion!(image: image, success: true)
                        }
                        
                    } else {
                        
                        println("Unable To Create Image From iTunes Data.")
                        if completion != nil {
                            completion!(image: nil, success: false)
                        }
                    }
                    
                } else {
                    println("Unable To Download iTunes Data. HTTP Response Status Code: \(httpResponse.statusCode)")
                    if completion != nil {
                        completion!(image: nil, success: false)
                    }
                }
            } else {
                println("Unable To Download iTunes Data. Connection Error: \(error.localizedDescription)")
                if completion != nil {
                    completion!(image: nil, success: false)
                }
            }
        })
        
        dataTask.resume()
    }
    
    
    //MARK: - Helper Methods
    
    func urlStringForItunesSearchString(searchTerm: String) -> String {
        
        // The iTunes API wants multiple terms separated by + symbols, so replace spaces with + signs
        let itunesSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        // Escape characters that are not URL-friendly then form and return URL string.
        if let escapedSearchString = itunesSearchTerm.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet()) {
            let urlString = "http://itunes.apple.com/search?term=" + escapedSearchString + "&media=software"
            //println("urlStringForItunesSearchString: \(urlString)")
            return urlString
        } else {    // Return a default search URL if escapedSearchString is somehow nil.
            return "http://itunes.apple.com/search?term=&media=software"
        }
    }
    
    func itunesItemsFromData(data: NSData) -> [ItunesItem] {
        
        var itunesItems = [ItunesItem]()
        
        var error: NSError?
        var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
        
        if error == nil {
            
            let results: NSArray = jsonResult["results"] as NSArray

            for item in results {

                if let itemDictionary = item as? NSDictionary {
                    
                    let itunesItem = ItunesItem()
                    
                    if let formattedPrice = itemDictionary["formattedPrice"] as? String {
                        itunesItem.formattedPrice = formattedPrice
                    }
                    
                    if let imageUrlString = itemDictionary["artworkUrl60"] as? String {
                        itunesItem.imageUrlString = imageUrlString
                    }
                    
                    /*if let imageUrlString = itemDictionary["artworkUrl60"] as? String {
                        let imageUrl = NSURL(string: imageUrlString)
                        let imageData = NSData(contentsOfURL: imageUrl!)
                        if let image = UIImage(data: imageData!) {
                            itunesItem.albumArtwork = image
                        }
                    }*/
                    
                    if let trackName = itemDictionary["trackName"] as? String {
                        itunesItem.trackName = trackName
                        
                        // Append the new itunesItem to the Array only if we get a name.
                        itunesItems.append(itunesItem)
                    }
                }
            }
            
        } else {
            
            // If there is an error parsing JSON, print it to the console
            println("JSON Error \(error!.localizedDescription)")
        }
        
        return itunesItems
    }
}


































































