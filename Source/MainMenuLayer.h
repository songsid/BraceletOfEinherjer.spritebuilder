//
//  MainMenuLayer.h
//  NUTheNord
//
//  Created by Sid on 2014/3/13.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//
@protocol MainMenuLayerDelegate <NSObject>
-(void) pushPlayerInfoScene;
-(void) pushLeagueScene;
-(void) selectFirstTime;
@end
#import "CCNode.h"

@interface MainMenuLayer : CCNode
{
 /*   CCButton * _left;
    CCButton * _right;
    CCButton * _rightUp;
    CCButton * _blockButton; */
       OALSimpleAudio * oal;
}
@property (nonatomic,weak) id <MainMenuLayerDelegate> delegate;
@property (nonatomic,weak) CCButton * left;
@property (nonatomic,weak) CCButton * right;
@property (nonatomic,weak) CCButton * rightUp;
@property (nonatomic,weak) CCButton * blockButton;
@end
