//
//  LeagueLayer.h
//  NUTheNord
//
//  Created by Sid on 2014/3/13.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//
@protocol LeagueLayerDelegate <NSObject>

-(void) popLeagueScene;
-(void) pushLevel;

-(void) controlSlide:(int)slide;
-(void) showLeagueInfo:(CGPoint)x :(int)level;
@end


#import "CCNode.h"
#import "CCAlertView.h"
#import "LeagueScene.h"
#import "LeagueInfo.h"
#define kSimpleTableViewRowHeight 24
#define kSimpleTableViewInset 50

@interface LeagueLayer : CCNode<LeagueSceneDelegate,CCAlertviewDelegate>
{

    CCButton * _isSelectLevel0;
//    CCButton * _isPopLeagueScene;
//    CCButton * _isSelectAreaOne;
//    CCButton * _isSelectAreaTwo;
    CCButton * _isLevel_0First;
    CCButton * _isLevel_1MC;
    LeagueInfo * leagueInfo;
    OALSimpleAudio *oal;
 //   int slide;
}


@property (nonatomic,weak) id <LeagueLayerDelegate> delegate;

@property (nonatomic,strong) NSArray * levels;
@property (nonatomic) int levelNum;
//@property (nonatomic) int tableInt;
//@property (nonatomic,strong) CCTableView* tableView ;
@property (nonatomic) BOOL blockButton;
@end


