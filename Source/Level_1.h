//
//  Level_1.h
//  NUTheNord
//
//  Created by Sid on 2014/3/17.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//
@protocol Level_1Delegate <NSObject>

-(void) popLevelScene;

@end

#import "CCNode.h"
#import "LevelScene.h"


@interface Level_1 : CCNode <CCPhysicsCollisionDelegate>
{
    CCPhysicsNode * _physicsNode;
    CCNode * _player;
    CCNode * _attack;
    CCNode * _endPosition;
    CCNode * _boss;
    CCNode * _enemy;
    CCNode * _road;
    CCNode * _sword;

    BOOL enableJump;
}
@property (nonatomic,weak) id <Level_1Delegate> delegate;

@property (nonatomic,assign) float yTarget;
@property (nonatomic,assign) float ySpeed;
@property (nonatomic,assign) CGPoint playerY;
@property (nonatomic,assign) float y;
@property (nonatomic,assign) float t;

-(void) attack;
@end
