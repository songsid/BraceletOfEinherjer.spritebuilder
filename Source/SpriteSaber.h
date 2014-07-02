//
//  SpriteSaber.h
//  NUTheNord
//
//  Created by Sid on 2014/5/22.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//
@protocol SaberDelegate <NSObject>

-(void) playerInfoLayerAdd :(id)sprite;

@end
#import "CCNode.h"

@interface SpriteSaber : CCSprite
{
    BOOL touchBeg;
    BOOL touchMov;
    CGPoint selfLocation;
    float buttonTime;
}
@property (nonatomic,weak) id<SaberDelegate> delegate;
@end
