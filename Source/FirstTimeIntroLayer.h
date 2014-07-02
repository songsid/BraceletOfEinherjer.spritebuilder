//
//  FirstTimeIntroLayer.h
//  NUTheNord
//
//  Created by Sid on 2014/3/15.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//
@protocol FirstTimeIntroLayer <NSObject>

-(void) firstTimeIntro;
-(void) firstTimeEnd;

@end
#import "CCNode.h"

@interface FirstTimeIntroLayer : CCNode
{
    int labelCount;
    BOOL lableSwitch;
    BOOL end;
    OALSimpleAudio *oal;
}

@property (nonatomic,weak) id <FirstTimeIntroLayer> delegate;
@property (nonatomic,weak) CCLabelTTF * talk;
@property (nonatomic,weak) CCNode * load;
@end
