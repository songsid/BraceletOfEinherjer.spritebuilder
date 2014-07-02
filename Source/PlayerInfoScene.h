//
//  PlayerInfoScene.h
//  NUTheNord
//
//  Created by Sid on 2014/3/13.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//


#import "PlayerInfoLayer.h"
#import "CCNode.h"
#import "SkipIntoLayer.h"
#import "SpriteSaber.h"

@interface PlayerInfoScene : CCScene <CCPhysicsCollisionDelegate,PlayerInfoLayerDelegate,SaberDelegate>
{

    CCScrollView * _playerInfoScrollView;
    CCScrollView * _spriteScrollView;
    CCLabelTTF * _spriteLabel;
 
    PlayerInfoLayer * playerInfo;
    SpriteSaber * spriteSaber;
    SpriteSaber * spriteArcher;
    SpriteSaber * spriteLancer;
    SpriteSaber * spriteSupVa;
    SpriteSaber * spriteSupSieg;
    SpriteSaber * spriteSupLain;
    
    CCButton * _block;
        OALSimpleAudio * oal;
    BOOL spriteOn;
    BOOL supOn;
    BOOL addInfo;
    id moveSprite;
    id rotatedSprite;
    id moveSprite2;
    id rotatedSprite2;
    id moveSup;
    id rotatedSup;
    id plusSprite;
    id plusSup;
    int lastSprite;
    int lastSup;
    
    id showLayer;
    id scaleLayer;
}

@property (nonatomic,strong) NSMutableArray * arraySprite;
@property (nonatomic,strong) NSMutableArray * arraySup;
-(void) playerInfoLayerRemove;
-(void) playerInfoLayerAdd :(id)sprite;
@end
