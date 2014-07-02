//
//  Level_1MCBoss.h
//  NUTheNord
//
//  Created by Sid on 2014/5/17.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//
@protocol Level_1MCBossDelegate <NSObject>
-(void) popLevelScene;
-(void) transHpDecrease :(int) damage;
-(void) transHpIncrease :(int) plus;
-(void) transMpDecrease :(int) mpcount;
-(void) transMpIncrease :(int) destance;
-(int) getHp;
-(int) getMp;
-(void) hpmpInfoOpacity: (BOOL) op;
-(void) touchToPaused :(BOOL) ny;
-(void) removeDialog;
-(BOOL) getPaused;
-(void) scrollViewShake;
-(void) showClearCount;
-(void) buttonControl: (BOOL) bo;
@end


#import "CCNode.h"
#import "HPMPInfo.h"

@class LevelScene;
@interface Level_1MCBoss : CCNode <CCPhysicsCollisionDelegate>
{
    LevelScene * _levelScene;
    CCPhysicsNode * _physicsNode;
    CCNode * _player;
    CCNode * _attack;
    CCNode * _endPosition;
    CCNode * _boss;
    CCNode * _enemy;
    CCNode * _kake;
    CCNode * _skillFire;
    CCNode * _skillBG;
    CCNode * _labBG1;
    CCNode * _labBG2;
    CCNode * _labBG3;
    CCNode * _blueGnd;
    CCNode * _beginGnd;
    CCNode * _blueTopGnd;
    CCNode * _mcBGnd1;
    CCNode * _mcBGnd2;
    CCNode * _oneStep;
    BOOL deltaStop;
    float mpDistance;
    float selfAnchorPosition;
    BOOL enableJump;
    BOOL enemyEnableJump;
    CGPoint skillPosition;
    CGPoint _playerY;
    int bRHP;
    int createOneF;
    
    int vinaSing;
    CGPoint stJump;
}

@property (nonatomic,weak) id<Level_1MCBossDelegate> delegate;
@property (nonatomic,weak) CCNode * sFire;
@property (nonatomic,strong) NSMutableArray * loopGnd;
@property (nonatomic,strong) NSMutableArray * arrayOneStep;
-(void) attack;
-(void) skill;
-(float) getSelfAnchorPosition;
-(BOOL) getDeltaStop;
@end
