//
//  Level_1MC.h
//  NUTheNord
//
//  Created by Sid on 2014/5/6.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//
@protocol Level_1MCDelegate <NSObject>
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
-(void) loadBoss;
@end

#import "CCNode.h"
#import "HPMPInfo.h"
#import "Dialog.h"

@class LevelScene;
@interface Level_1MC : CCNode <CCPhysicsCollisionDelegate>
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
   // CCNode * _robertShot;
   // CCNode * _robertShotTwo;
    CCNode * _labBG1;
    CCNode * _labBG2;
    CCNode * _labBG3;
    CCNode * _blueGnd;
    CCNode * _beginGnd;
    CCNode * _blueTopGnd;
    //CCNode * _robertShotPre;
    //CCNode * _bRobert;
    CCNode * _skillFire;
    
    
    CCNode * _skillBG;
    CCNode * _mcBGFront;
    CCNode * _mcBGFrontUp;
    
    CCNode * _layer1k;
    CCNode * _layer2k;
    CCNode * _layer3k;
    CCNode * _layer4k;
    CCNode * _layer5k;

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
@property (nonatomic,weak) id<Level_1MCDelegate> delegate;
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
