//
//  ClearCount.h
//  NUTheNord
//
//  Created by Sid on 2014/5/2.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//
@protocol ClearCountDelegate <NSObject>

-(void) popLevelScene;

@end

#import "CCNode.h"

@interface ClearCount : CCNode

@property (nonatomic,weak) id <ClearCountDelegate> delegate;

@end
