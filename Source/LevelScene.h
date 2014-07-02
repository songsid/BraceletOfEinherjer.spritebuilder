//
//  LevelScene.h
//  NUTheNord
//
//  Created by Sid on 2014/3/13.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//



#import "CCNode.h"
#import "LeagueScene.h"
#import "Level_1MC.h"
#import "Level_0First.h"
#import "Level_1MCBoss.h"
#import "HPMPInfo.h"
#import "Dialog.h"
#import "ClearCount.h"
#import "PauseSetting.h"
#import "FailCount.h"
#import "Level_1MCBoss.h"
#import "Level00.h"

@interface LevelScene : CCScene <LeagueSceneDelegate,Level_FirstDelegate,DialogDelegate,Level_1MCDelegate,ClearCountDelegate,PauseSettingDelegate,FailCountDelegate,Level_1MCBossDelegate,Level00Delegate>
{

    CCButton * _skillOne;
    CCButton * _skillTwo;
    CCButton * _attack;
    CCButton * _pausedButton;
    HPMPInfo * info;
    Dialog * diag;
    ClearCount * clearCo;
    Level_0First * leveLab;
    Level_1MC * levelMc;
    Level_1MCBoss * levelMcBoss;
    Level00 * levelTest;
    CCNode * _dialog;
    PauseSetting * pausedS;
    int count;
        OALSimpleAudio * oal;
    
    CCNode * _mcBG1_1;
    CCNode * _mcBG1_2;
    CCNode * _mcBG2_1;
    CCNode * _mcBG2_2;
    CCNode * _mcBG3_1;
    CCNode * _mcBG3_2;
    CCNode * _mcBG4_1;
    CCNode * _mcBG4_2;
    
    CCNode * _skillOk;
    NSArray * _BG1;
    NSArray * _BG2;
    NSArray * _BG3;
    NSArray * _BG4;
    
}
//@property (nonatomic, weak) CCNode * currentLevel;
@property (nonatomic, weak) CCNode * HPMP;
@property (nonatomic) BOOL entered;
@property (nonatomic, weak) CCScrollView * levelSceneScrollView;
//@property (nonatomic) LeagueScene * league;

-(void) popLevelScene;
-(void) transHpDecrease :(int) damage;
-(void) transHpIncrease :(int) plus;
-(void) transMpDecrease :(int) mpcount;
-(void) transMpIncrease :(int) destance;
-(int) getHp;
-(int) getMp;
-(void) touchToPaused:(BOOL)ny;
-(void) removeDialog;
-(BOOL) getPaused;
-(void) scrollViewShake;
-(void) closePause;
-(void) buttonControl: (BOOL) bo;
-(void) reloadGame;
-(void) appearFailCount;
-(void) hpmpInfoOpacity: (BOOL) op;
-(void) loadBoss;
@end
