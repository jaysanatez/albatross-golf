//
//  Scorecard.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 5/23/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import "ScorecardVC.h"
#import "HoleScoreCell.h"
#import "HoleScoreVC.h"
#import "TeeHoleDAO.h"
#import "TeeHole.h"

@interface ScorecardVC ()
{
    TeeHoleDAO *dao;
}

@end

@implementation ScorecardVC

@synthesize collecView, round, tee, teeHoles, spinnerView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [collecView registerNib:[UINib nibWithNibName:@"HoleScoreCell" bundle:[NSBundle mainBundle]]  forCellWithReuseIdentifier:@"HoleScore"];
    
    spinnerView.layer.cornerRadius = 8;
    spinnerView.layer.masksToBounds = YES;
    
    self.title = tee.course_name;
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:102.0/255.5
                                                                        green:1.0
                                                                         blue:102.0/255.0
                                                                        alpha:0.8];
    dao = [[TeeHoleDAO alloc] init];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self displayLoadingScreen:NO];
    dao.delegate = self;
    [dao fetchTeeHolesForTee:tee.id_num];
}

- (void)refreshTeeHoles:(NSMutableArray *)tHoles
{
    teeHoles = tHoles;
    [collecView reloadData];
    [self displayLoadingScreen:YES];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [teeHoles count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"HoleScore";
    HoleScoreCell *hole = [collecView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    TeeHole *tHole = (TeeHole *)[teeHoles objectAtIndex:indexPath.row];
    hole.teeHole = tHole;
    [hole reloadLabels];
    return hole;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HoleScoreVC *holeScore = [[HoleScoreVC alloc] initWithNibName:@"HoleScoreVC" bundle:[NSBundle mainBundle]];
    TeeHole *tHole = (TeeHole *)[teeHoles objectAtIndex:indexPath.row];
    holeScore.teeHole = tHole;
    holeScore.courseName = tee.course_name;
    [self.navigationController pushViewController:holeScore animated:YES];
}

- (void)displayLoadingScreen:(BOOL)fetchedCourses
{
    spinnerView.hidden = fetchedCourses;
}

@end
