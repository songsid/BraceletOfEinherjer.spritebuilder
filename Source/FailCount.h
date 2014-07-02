//
//  FailCount.h
//  NUTheNord
//
//  Created by Sid on 2014/5/12.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//
@protocol FailCountDelegate <NSObject>

-(void) closePause;
-(void) popLevelScene;
-(void) reloadGame;

@end
#import "CCNode.h"
#import "CCAlertView.h"
@interface FailCount : CCNode <CCAlertviewDelegate>
{
    CCButton * _restart;
    CCButton * _leftLevel;
    BOOL reloadGame;
}
@property (nonatomic,weak) id<FailCountDelegate> delegate;
@end
