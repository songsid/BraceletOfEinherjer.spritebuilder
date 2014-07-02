//
//  LeagueScene.h
//  NUTheNord
//
//  Created by Sid on 2014/3/13.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//
@protocol LeagueSceneDelegate <NSObject>



@end


#import "CCNode.h"
#import "LeagueLayer.h"
#import "LeagueInfo.h"
@class LevelScene;
@interface LeagueScene : CCScene<LeagueLayerDelegate,CCAlertviewDelegate>
{
    
    CCScrollView * _leagueSceneScrollView;
    CCButton * _enter;
    CCButton * _cancel;
    CCButton * _block;
    CCNode * _enterFire;
    LeagueInfo * leagueInfo;
    OALSimpleAudio * oal;
    BOOL showInfo;
    int levelCount;
    BOOL blockPop;
}
@property (nonatomic,weak) id <LeagueSceneDelegate> delegate;
//@property (nonatomic) CCScene * level;
-(void) popLeagueScene;
-(void) pushLevel;
//-(void) intoLevelOrNot;
-(void) controlSlide:(int)slide;
-(void) showLeagueInfo:(CGPoint)x :(int)level;
@end
