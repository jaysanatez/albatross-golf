//
//  PastRoundTableViewCell.swift
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/15/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

import UIKit

class PastRoundTableViewCell: UITableViewCell
{
    @IBOutlet var course_name:UILabel!
    @IBOutlet var date_player:UILabel!
    @IBOutlet var total_score:UILabel!
    var round:Round
    
    required init(coder aDecoder: NSCoder)
    {
        round = Round()
        super.init(coder: aDecoder)
    }
    
    func reloadLabels()
    {
        course_name.text = round.course_name
        course_name.adjustsFontSizeToFitWidth = true
        
        total_score.text = round.is_complete ? "\(round.getRoundScore())" : "Unfinished"
        
        var dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        date_player.text = dateFormatter.stringFromDate(round.date_played)
    }
}
