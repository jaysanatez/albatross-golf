//
//  RoundStatsDAO.swift
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/15/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

import UIKit

class RoundStatsDAO
{
    let base_url:String = "http://brobin.pythonanywhere.com/v1/"
    var delegate:RoundStatsFetchDelegate?
    
    init()
    {
    
    }
    
    func fetchStatsForRound(round_id:NSNumber)
    {
        var url_string:String = "round/\(round_id)/stats"
        self.submitRoundFetchRequest(url_string, round_id:round_id)
    }
    
    func submitRoundFetchRequest(url_string:String, round_id:NSNumber)
    {
        var api_url = "\(base_url)\(url_string)"
        println("REQUESTED URL: \(api_url)")
        var url:NSURL = NSURL(string: api_url)!
        var body:String = ""
        var token:String = "7ebb3f3d899a23bcb680ebcdc50e247fc4d21fca"
        var token_header:String = "Token \(token)"
        var url_request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        
        url_request.timeoutInterval = 30.0
        url_request.HTTPMethod = "GET"
        url_request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion:false)
        url_request.addValue(token_header, forHTTPHeaderField:"Authorization")
        var queue:NSOperationQueue = NSOperationQueue()
    
        // the donger
        NSURLConnection.sendAsynchronousRequest(url_request, queue: queue, completionHandler:{
            (response:NSURLResponse?, data:NSData!, error:NSError!) in
            if data.length > 0 && error == nil
            {
                // do the things
                dispatch_async(dispatch_get_main_queue(), {
                    var r_s:RoundStats = self.parseRoundStatData(data)
                    self.swiftIsDumb(round_id, r_s:r_s)
                })
            }
            else if data.length == 0
            {
                println("Round retrieval returned an empty response.")
            }
            else if error != nil
            {
                println("ERROR: \(error.description)");
            }
        })
    }
    
    func swiftIsDumb(round_id:NSNumber, r_s:RoundStats)
    {
        // delegate?.roundStatsForRound(round_id, roundStats:r_s)
    }
    
    func parseRoundStatData(data:NSData) -> RoundStats
    {
        var round_stats:RoundStats = RoundStats()
        
        var my_data:NSString = NSString(data: data, encoding:NSUTF8StringEncoding)!
        println("JSON data = \(my_data.length > 100 ?  my_data.substringToIndex(100) : my_data)")
        var error:NSError?
        
        // parse that bad boy
        var json_object:AnyObject = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.AllowFragments, error:&error)!
        
        if  error == nil && json_object.isKindOfClass(NSDictionary)
        {
            var js:NSDictionary = json_object as NSDictionary
            println("Successfully deserialized.")
            
            round_stats.par_3_avg = js.valueForKey("par_3_avg") as Double
            round_stats.par_4_avg = js.valueForKey("par_4_avg") as Double
            round_stats.par_5_avg = js.valueForKey("par_5_avg") as Double
        }
        
        return round_stats
    }
}
