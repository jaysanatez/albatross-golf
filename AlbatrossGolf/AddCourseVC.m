//
//  AddCourse.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 5/28/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import "AddCourseVC.h"
#import "CourseChoiceVC.h"
#import "Course.h"
#import "CourseDAO.h"

@interface AddCourse ()
{
    int holeNum;
}

@end

@implementation AddCourse

@synthesize name,loc,par,rating,slope,pars,tap,array,par3,par4,par5,undo;
@synthesize par3Height,par4Height,par5Height,undoHeight,textFieldFromBottom;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /* UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width-190,
                                                                    self.navigationController.navigationBar.bounds.size.height)];
    titleLabel.text= @"Add a Course";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:@"Iowan Old Style" size:18];
    titleLabel.textAlignment = NSTextAlignmentRight;
    self.navigationItem.titleView = titleLabel;
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:102.0/255.5
                                                                        green:1.0
                                                                         blue:102.0/255.0
                                                                        alpha:0.8];
    
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    pars.text = @"Hole 1:";
    holeNum = 1;
    array = [[NSMutableArray alloc] init];
    pars.editable = NO;
    
    name.font = [UIFont fontWithName:@"Iowan Old Style" size:16];
    loc.font = [UIFont fontWithName:@"Iowan Old Style" size:16];
    par.font = [UIFont fontWithName:@"Iowan Old Style" size:16];
    rating.font = [UIFont fontWithName:@"Iowan Old Style" size:16];
    slope.font = [UIFont fontWithName:@"Iowan Old Style" size:16];
    
    pars.clipsToBounds = YES;
    pars.layer.cornerRadius = 10.0;
    
    // resize all the things
    if(!IS_IPHONE_5)
    {
        par3Height.constant = 40;
        par4Height.constant = 40;
        par5Height.constant = 40;
        undoHeight.constant = 40;
        
        par3.titleLabel.font = [UIFont fontWithName:par3.titleLabel.font.fontName
                                               size:par3.titleLabel.font.pointSize-10];
        
        par4.titleLabel.font = [UIFont fontWithName:par4.titleLabel.font.fontName
                                               size:par4.titleLabel.font.pointSize-10];
        
        par5.titleLabel.font = [UIFont fontWithName:par5.titleLabel.font.fontName
                                               size:par5.titleLabel.font.pointSize-10];
        
        pars.scrollEnabled = YES;
        pars.scrollsToTop = NO;
        textFieldFromBottom.constant = 100;
    } */
}

-(void)dismissKeyboard
{
    [name resignFirstResponder];
    [loc resignFirstResponder];
    [par resignFirstResponder];
    [rating resignFirstResponder];
    [slope resignFirstResponder];
    [pars resignFirstResponder];
}

-(IBAction)addCourse:(id)sender
{
    /*Course *newCourse = [[Course alloc]init];
    newCourse.courseName = name.text;
    newCourse.courseLocation = loc.text;
    newCourse.coursePar = [NSNumber numberWithInt:[par.text intValue]];
    newCourse.courseRating = [NSNumber numberWithDouble:[rating.text doubleValue]];
    newCourse.courseSlope = [NSNumber numberWithInt:[slope.text intValue]];
    newCourse.parSequence = array;
    
    if(![name.text isEqualToString:@""] && ![loc.text isEqualToString:@""] && ![par.text isEqualToString:@""] &&
       ![rating.text isEqualToString:@""] && ![slope.text isEqualToString:@""] &&
       !([pars.text rangeOfString:@"Hole 18"].location == NSNotFound))
    {
        if([self totalPar:array] != [par.text intValue])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Conflicting Data"
                                                            message:@"Your par sequence and course par do not match."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            // add db stuff
            CourseDAO *dao = [[CourseDAO alloc] init];
            [dao addCourse:newCourse];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Form Incomplete"
                                                        message:@"One (or more) or the fields required were left blank. Please complete form."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }*/
}

-(int)totalPar:(NSMutableArray *)scores
{
    int sum = 0;
    for(int i=0; i<18; i++)
    {
        sum += [[array objectAtIndex:i] intValue];
    }
    return sum;
}

-(IBAction)par3:(id)sender
{
    [self addPar:3];
}

-(IBAction)par4:(id)sender
{
    [self addPar:4];
}

-(IBAction)par5:(id)sender
{
    [self addPar:5];
}

-(void)addPar:(int)parNum
{
    if (holeNum < 18)
    {
        pars.text = [[NSString alloc] initWithFormat:@"%@ %i  \tHole %i:",pars.text,parNum,holeNum+1];
        [array addObject:[NSNumber numberWithInt:parNum]];
        holeNum++;
    }
    else if(holeNum == 18)
    {
        pars.text = [[NSString alloc] initWithFormat:@"%@ %i",pars.text,parNum];
        [array addObject:[NSNumber numberWithInt:parNum]];
        holeNum++;
    }
}

-(IBAction)undoParSequenceEntry:(id)sender
{
    if(![pars.text isEqualToString:@"Hole 1:"])
    {
        NSString *string = @"Hole 1:";
        [array removeObjectAtIndex:holeNum-2];
        holeNum--;
        for(int i=0; i<holeNum-1; i++)
                string = [NSString stringWithFormat:@"%@ %@ \tHole %i:",string,[array objectAtIndex:i],i+2];
        pars.text = string;
    }
}

-(void)scrollTextViewToBottom
{
    if(pars.text.length > 0 )
    {
        NSRange bottom = NSMakeRange(pars.text.length - 1, 1);
        [pars scrollRangeToVisible:bottom];
    }
    
}

@end
