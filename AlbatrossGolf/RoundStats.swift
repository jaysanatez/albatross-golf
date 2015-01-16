//
//  RoundStats.swift
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/15/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

import UIKit

class RoundStats
{
    var total_score:NSInteger
    
    var par_3_avg:Double
    var par_4_avg:Double
    var par_5_avg:Double
    
    var num_eagles:NSInteger
    var num_birdies:NSInteger
    var num_pars:NSInteger
    var num_bogeys:NSInteger
    var num_double_bogeys:NSInteger
    var num_doubles_plus:NSInteger
    
    var num_greens_hit:NSInteger
    var num_greens_possible:NSInteger
    
    var num_fairways_hit:NSInteger?
    var num_fairways_possible:NSInteger?
    
    var num_par_saves:NSInteger?
    var num_par_saves_possible:NSInteger?
    
    var num_sand_saves:NSInteger?
    var num_sand_saves_possible:NSInteger?
    
    var num_putts:NSInteger?
    var num_penalty_strokes:NSInteger?
    
    var num_one_putts:NSInteger?
    var num_three_putts:NSInteger?
    
    var num_bunkers_hit:NSInteger?
    
    init()
    {
        total_score = 0
        
        par_3_avg = 0
        par_4_avg = 0
        par_5_avg = 0
        
        num_eagles = 0
        num_birdies = 0
        num_pars = 0
        num_bogeys = 0
        num_double_bogeys = 0
        num_doubles_plus = 0
        
        num_greens_hit = 0
        num_greens_possible = 0
    }
    
    func getGIRFrac() -> String
    {
        return "\(num_greens_hit)/\(num_greens_possible)"
    }
    
    func getGIRPerc() -> String
    {
        return NSString(format: "%.2f", Double(num_greens_hit) / Double(num_greens_possible) * 100)
    }
    
    func getFairwayFrac() -> String
    {
        return "\(num_fairways_hit)/\(num_fairways_possible)"
    }
    
    func getFairwayPerc() -> String
    {
        return NSString(format: "%.2f", Double(num_fairways_hit!) / Double(num_fairways_possible!) * 100)
    }
    
    func getParSaveFrac() -> String
    {
        return "\(num_par_saves!)/\(num_par_saves_possible!)"
    }
    
    func getParSavePerc() -> String
    {
        return NSString(format: "%.2f", Double(num_par_saves!) / Double(num_par_saves_possible!) * 100)
    }
    
    func getSandSaveFrac() -> String
    {
        return "\(num_sand_saves!)/\(num_sand_saves_possible!)"
    }
    
    func getSandSavePerc() -> String
    {
        return NSString(format: "%.2f", Double(num_sand_saves!) / Double(num_sand_saves_possible!) * 100)
    }
}
