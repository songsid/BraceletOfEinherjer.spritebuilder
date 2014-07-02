//
//  Level_0First.h
//  NUTheNord
//
//  Created by Sid on 2014/4/12.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//
@protocol Level_FirstDelegate <NSObject>

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

@class LevelScene;
@interface Level_0First : CCNode <CCPhysicsCollisionDelegate,UIGestureRecognizerDelegate>
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
    CCNode * _robertShot;
    CCNode * _robertShotTwo;
    CCNode * _labBG1;
    CCNode * _labBG2;
    CCNode * _labBG3;
    CCNode * _blueGnd;
    CCNode * _beginGnd;
    CCNode * _blueTopGnd;
    CCNode * _robertShotPre;
    CCNode * _bRobert;
    CCNode * _skillFire;
    //NSMutableArray * _enemies;
        OALSimpleAudio * oal;
    CCNode * _skillBG;
    BOOL deltaStop;
    float mpDistance;
    float selfAncherPosition;
    BOOL enableJump;
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
    
    int vinaSing;
    CGPoint stJump;
    BOOL mouseExisted;
}

@property (nonatomic,weak) id <Level_FirstDelegate> delegate;
@property (nonatomic,assign) float yTarget;
@property (nonatomic,assign) float ySpeed;
@property (nonatomic,assign) CGPoint playerY;
@property (nonatomic,assign) float y;
@property (nonatomic,assign) float t;
@property (nonatomic,weak) CCNode * sFire;
@property (nonatomic, strong) NSMutableArray *enemies;

-(void) attack;
-(void) skill;
@end

