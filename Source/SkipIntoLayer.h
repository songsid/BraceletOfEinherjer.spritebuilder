//
//  SkipIntoLayer.h
//  NUTheNord
//
//  Created by Sid on 2014/3/13.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//
@protocol SkipIntoLayerDelegate <NSObject>

-(void) skipInto;

@end
#import "CCNode.h"

@interface SkipIntoLayer : CCNode
@property (nonatomic,weak) id<SkipIntoLayerDelegate> delegate;
@end
