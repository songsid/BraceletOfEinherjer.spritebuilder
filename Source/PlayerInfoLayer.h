//
//  PlayerInfoLayer.h
//  NUTheNord
//
//  Created by Sid on 2014/3/13.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//
@protocol PlayerInfoLayerDelegate <NSObject>
-(void) playerInfoLayerRemove;

@end
#import "CCNode.h"

#import "SpriteSaber.h"
@class PlayerInfoScene;
@interface PlayerInfoLayer : CCNode
{
    CCButton * _bgButton;
 
    CCLabelTTF * _spirit;
    CCLabelTTF * _class;
    CCLabelTTF * _attack;
    CCLabelTTF * _skill;
    
    CCNode * _saber;
    CCNode * _archer;
    CCNode * _lancer;
    
    CCNode * _supLi;
    CCNode * _supSieg;
    CCNode * _supVa;
}
@property (nonatomic,weak) id<PlayerInfoLayerDelegate> delegate;
-(void) setLabel : (id)name;
@end
