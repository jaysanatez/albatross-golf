//
//  AddCourse.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 5/28/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCourse : UIViewController

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *par3Height, *par4Height, *par5Height, *undoHeight;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *textFieldFromBottom;
@property (nonatomic, strong) IBOutlet UIButton *par3, *par4, *par5, *undo;
@property (nonatomic, strong) IBOutlet UITextField *name, *loc, *par, *rating, *slope;
@property (nonatomic, strong) IBOutlet UITextView *pars;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, strong) NSMutableArray *array;

-(IBAction)addCourse:(id)sender;
-(IBAction)par3:(id)sender;
-(IBAction)par4:(id)sender;
-(IBAction)par5:(id)sender;
-(IBAction)undoParSequenceEntry:(id)sender;

@end
