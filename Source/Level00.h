//
//  Level00.h
//  BraceletOfEinherjar
//
//  Created by Sid on 2014/6/24.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

@protocol Level00Delegate <NSObject>
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
-(void) appearFailCount;


@end



#import "CCNode.h"
#import "HPMPInfo.h"
#import "Dialog.h"

@class LevelScene;
@interface Level00 : CCNode <CCPhysicsCollisionDelegate>
{
    LevelScene * _levelScene;
    CCPhysicsNode * _physicsNode;
    CCNode * _player;
    CCNode * _attack;
    CCNode * _endPosition;
    CCNode * _boss;
    CCNode * _enemy;
    CCNode * _road;
    CCNode * _sword;
    CCNode * _kake;
    
    CCNode * _skillFire;
    CCNode * _skillBG;
    
    BOOL deltaStop;
    float mpDistance;
    float selfAnchorPosition;
    
    BOOL enableJump;
    BOOL enemyEnableJump;
    BOOL dialogOne;
    BOOL dialogTwo;
    BOOL dialogThree;
    BOOL dialogFour;
    BOOL dialogTouchOne;
    BOOL dialogButtonOne;
    BOOL roberShotBo;
    BOOL endgame;
    CGPoint skillPosition;
    int bRHP;
    int tutorialStep;
    int enemyAttackStep;
    int setLayer;
    
    int vinaSing;
    CGPoint stJump;
    OALSimpleAudio * oal;
}

@property (nonatomic,weak) id<Level00Delegate> delegate;
@property (nonatomic,assign) float yTarget;
@property (nonatomic,assign) float ySpeed;
@property (nonatomic,assign) CGPoint playerY;
@property (nonatomic,assign) float y;
@property (nonatomic,assign) float t;
@property (nonatomic,weak) CCNode * sFire;
@property (nonatomic,strong) NSMutableArray * arrayEnemyBat;
@property (nonatomic,strong) NSMutableArray * arrayEnemyPig;
@property (nonatomic,strong) NSMutableArray * arrayGnd;

-(void) attack;
-(void) skill;
-(float) getSelfAnchorPosition;
-(BOOL) getDeltaStop;
@end
