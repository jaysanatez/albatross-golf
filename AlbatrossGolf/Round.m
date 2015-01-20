//
//  Round.m
//  Albatross Golf
//
//  Created by Jacob Sanchez on 10/19/14.
//  Copyright (c) 2014 jacobSanchez. All rights reserved.

#import "Round.h"

@implementation Round

@synthesize hole_scores;

- (BOOL)frontNineIsCompleted
{
    for (HoleScore *hs in hole_scores)
    {
        if(hs.hole_number > 0 && hs.hole_number < 10 && hs.score == -1)
        {
            return false;
        }
    }
    return true;
}

- (BOOL)backNineIsComplete
{
    for (HoleScore *hs in hole_scores)
    {
        if(hs.hole_number > 9 && hs.hole_number < 19 && hs.score == -1)
        {
            return false;
        }
    }
    return true;
}

- (int)getFrontNinePar
{
    int par_total = 0;
    
    for (HoleScore *hs in hole_scores)
    {
        if(hs.hole_number > 0 && hs.hole_number < 10)
        {
            par_total += hs.hole_par;
        }
    }
    
    return par_total;
}

- (int)getBackNinePar
{
    int par_total = 0;
    
    for (HoleScore *hs in hole_scores)
    {
        if(hs.hole_number > 9 && hs.hole_number < 19)
        {
            par_total += hs.hole_par;
        }
    }
    
    return par_total;
}

- (int)getFrontNineTotal
{
    int par_total = 0;
    
    for (HoleScore *hs in hole_scores)
    {
        if(hs.hole_number > 0 && hs.hole_number < 10)
        {
            par_total += hs.score;
        }
    }
    
    return par_total;
}

- (int)getBackNineTotal
{
    int par_total = 0;
    
    for (HoleScore *hs in hole_scores)
    {
        if(hs.hole_number > 9 && hs.hole_number < 19)
        {
            par_total += hs.score;
        }
    }
    
    return par_total;
}

@end
