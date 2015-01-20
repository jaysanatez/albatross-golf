//
//  SavingThrobberView.swift
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/20/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

import UIKit

class SavingThrobberView: UIView
{
    @IBOutlet var view:UIView!
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("SavingThrobberView", owner:self, options:nil)
        addSubview(view)
    }
}
