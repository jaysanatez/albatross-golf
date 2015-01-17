//
//  LoadingThrobberVIew.swift
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/16/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

import UIKit

class LoadingThrobberVIew: UIView
{
    @IBOutlet var view:UIView!
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("LoadingThrobberView", owner:self, options:nil)
        addSubview(view)
    }
}
