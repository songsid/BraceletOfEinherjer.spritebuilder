//
//  ClearCount.m
//  NUTheNord
//
//  Created by Sid on 2014/5/2.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import "ClearCount.h"

@implementation ClearCount
-(void) didLodaFromCCB
{
}

-(void) completeTrue:(id)sender
{
    [self.delegate popLevelScene];
    CCLOG(@"completetrue");
}
@end
