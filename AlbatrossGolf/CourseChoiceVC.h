//
//  CourseChoiceController.h
//  Albatross Golf
//
//  Created by Jacob Sanchez on 5/21/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import <UIKit/UIKit.h>
#import "Delegates.h"
#import "Course.h"
#import "CourseDAO.h"
@class LoadingThrobberView;

@interface CourseChoice : UIViewController <UITableViewDataSource, UITableViewDelegate, CourseFetchDelegate>

@property (nonatomic, weak) IBOutlet UITextField *searchField;
@property (nonatomic, weak) IBOutlet UILabel *noCoursesLabel;
@property (nonatomic, weak) IBOutlet UITableView *table;
@property (nonatomic, weak) IBOutlet LoadingThrobberView *spinnerView;
@property (nonatomic, weak) IBOutlet UISegmentedControl *segment;
@property (nonatomic, weak) IBOutlet UIButton *previousPage, *nextPage, *continueButton;

- (void)alertNoCoursesFetched;
- (void)setPrevButton:(BOOL)prev andNext:(BOOL)next;
- (IBAction)clearSearchParameters:(id)sender;
- (IBAction)searchByTapped:(id)sender;
- (IBAction)showPrevPagination:(id)sender;
- (IBAction)showNextPagination:(id)sender;

@end
