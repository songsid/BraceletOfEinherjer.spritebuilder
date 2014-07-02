//
//  PlayerInfoScene.m
//  NUTheNord
//
//  Created by Sid on 2014/3/13.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import "PlayerInfoScene.h"
#import "AppDelegate.h"

@implementation PlayerInfoScene
-(NSMutableArray *) arraySprite
{
    if (!_arraySprite) {
        _arraySprite = [NSMutableArray array];
    }
    return  _arraySprite;
}
-(NSMutableArray *) arraySup
{
    if (!_arraySup) {
        _arraySup = [NSMutableArray array];
    }
    return  _arraySup;
}
-(void) didLoadFromCCB
{
    _block.visible = NO;
    _block.zOrder = 10;
    self.userInteractionEnabled = TRUE;
    PlayerInfoLayer * infoLayer = (PlayerInfoLayer *)[CCBReader load:@"PlayerInfoLayer"];
    _playerInfoScrollView.contentNode = infoLayer;
    _playerInfoScrollView.anchorPoint = ccp(0, 0);
    _playerInfoScrollView.position = ccp(0, 0);
    if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad){ self.scale = 1.07;}
    _spriteScrollView.anchorPoint = ccp(0, 0);
    _spriteScrollView.position = ccp(0, 0);
    NSString *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    int score = [[NSUserDefaults standardUserDefaults] integerForKey:@"score"];
    NSLog(@"Welcome! %@\n Your current score is %d.", user, score);
    _spriteLabel.anchorPoint = ccp(0,1);
    _spriteLabel.position =ccp(140, 301);
    _spriteLabel.string = [NSString stringWithFormat:@"fdfsaweraef"];


 
    spriteSaber = (SpriteSaber * )[CCBReader load:@"SpriteSaber"];
    spriteSaber.position = ccp(45, 64);
    spriteSaber.physicsBody.collisionType = @"Sprite";
    spriteSaber.delegate  = self;
    [self addChild:spriteSaber z:0];
    [self.arraySprite addObject:spriteSaber];
    
    spriteLancer = (SpriteSaber * )[CCBReader load:@"SpriteLancer"];
    spriteLancer.position = ccp(145, 64);
    spriteLancer.physicsBody.collisionType = @"Sprite";
    spriteLancer.delegate = self;
    [self addChild:spriteLancer z:0];
    [self.arraySprite addObject:spriteLancer];
    
    spriteArcher = (SpriteSaber * )[CCBReader load:@"SpriteArcher"];
    spriteArcher.position = ccp(200, 64);
    spriteArcher.physicsBody.collisionType =@"Sprite";
    spriteArcher.delegate =  self;
    [self addChild:spriteArcher z:0];
    [self.arraySprite addObject:spriteArcher];
    
    
    spriteSupLain = (SpriteSaber *)[CCBReader load:@"SpriteSupportLainDau"];
    spriteSupLain.position = ccp(402, 64);
    spriteSupLain.delegate = self;
    [self addChild:spriteSupLain];
    [self.arraySup addObject:spriteSupLain];
    
    spriteSupSieg = (SpriteSaber *)[CCBReader load:@"SpriteSupportSiegfried"];
    spriteSupSieg.position = ccp(350, 64);
    spriteSupSieg.delegate = self;
    [self addChild:spriteSupSieg];
    [self.arraySup addObject:spriteSupSieg];
    
    spriteSupVa = (SpriteSaber * )[CCBReader load:@"SpriteSupportVaina"];
    spriteSupVa.position = ccp(300, 64);
    spriteSupVa.delegate = self;
    [self addChild:spriteSupVa];
    [self.arraySup addObject:spriteSupVa];
    //
    oal = [OALSimpleAudio sharedInstance];
    [oal stopAllEffects];
   // [oal playEffect:@"spiritMusic.caf" loop:YES];

    
    ///set Action

    moveSprite = [CCActionMoveTo actionWithDuration:0.3f position:ccp(116, 208)];
    rotatedSprite = [CCActionRotateTo actionWithDuration:0.3f angle:0.0f];
    moveSprite2 = [CCActionMoveTo actionWithDuration:20.0f position:ccp(116, 208)];
//    rotatedSprite = [CCActionRotateTo actionWithDuration:20.0f angle:0.0f];
    plusSprite = [CCActionSequence actions:moveSprite,rotatedSprite,moveSprite2, nil];
    

}
-(void) popPlayerInfoScene:(id)sender  // 離開英靈選單
{
   /*
    AppController *appDelegate = (AppController *)[[UIApplication sharedApplication] delegate];
    [appDelegate performSelector:@selector(rebuildMainScene) withObject:nil afterDelay:0.2];
    */
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"Rebuild"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    _block.visible = YES;
    CCTransition * trans = [CCTransition transitionFadeWithDuration:0.2f];
    [[CCDirector sharedDirector]replaceScene:[CCBReader loadAsScene:@"MainScene"] withTransition:trans];
 //   CCScene * sce = [CCBReader loadAsScene:@"MainScene"];
 //   [[CCDirector sharedDirector]runWithScene:sce];
  //  [[OALSimpleAudio sharedInstance] stopAllEffects];
  //  [[OALSimpleAudio sharedInstance] playEffect:@"d5.mp3" loop:YES];
}
-(void)update:(CCTime)delta  //各種移動設定
{
    if (!addInfo) {
    for (CCNode * sprite in _arraySprite) {
        
        if (((sprite.position.y+sprite.contentSize.height * .3 > 208) && (sprite.position.y-sprite.contentSize.height * .3 < 208) && (sprite.position.x+sprite.contentSize.width * .3 > 116) && (sprite.position.x-sprite.contentSize.width * .3 < 116))) {
            CCLOG(@"got!!");
            spriteOn = YES;
            [sprite stopAllActions];
            lastSprite = [[NSUserDefaults standardUserDefaults]integerForKey:@"Spirit"];
            if([sprite isEqual:spriteSaber])[[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"Spirit"];
            if ([sprite isEqual:spriteLancer])[[NSUserDefaults standardUserDefaults]setInteger:1 forKey:@"Spirit"];
            if ([sprite isEqual:spriteArcher])[[NSUserDefaults standardUserDefaults]setInteger:2 forKey:@"Spirit"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }
        if (spriteOn) {
            spriteOn = NO;
            switch (lastSprite) {
                case 0:
                {
                    spriteSaber.position = ccp(242, 231);
                  //  [[OALSimpleAudio sharedInstance] playEffect:@"spiritUP.mp3" loop:NO];
                    id mov  = [CCActionMoveTo actionWithDuration:3.0f position:ccp(45, 64)];
                    [spriteSaber runAction:mov];
                }
                    break;
                case 1:
                {
                    spriteLancer.position = ccp(242, 231);
                  //  [[OALSimpleAudio sharedInstance] playEffect:@"spiritUP.mp3" loop:NO];
                    id mov  = [CCActionMoveTo actionWithDuration:3.0f position:ccp(145, 64)];
                    [spriteLancer runAction:mov];
                }
                    break;
                case 2:
                {
                  //  [[OALSimpleAudio sharedInstance] playEffect:@"spiritUP.mp3" loop:NO];
                    spriteArcher.position = ccp(242, 231);
                    id mov  = [CCActionMoveTo actionWithDuration:3.0f position:ccp(200, 64)];
                    [spriteArcher runAction:mov];
                }
                    break;
                default:
                    break;
            }
        }

    }
 }
 
    switch ([[NSUserDefaults standardUserDefaults]integerForKey:@"Spirit"]) {
        case 0:
            spriteSaber.position = ccp(116, 208);
            break;
        case 1:
            spriteLancer.position = ccp(116, 208);
            break;
        case 2:
            spriteArcher.position  = ccp(116, 208);
            break;
        default:
            break;
    }
    if (spriteSaber.position.x <49 && spriteSaber.position.x >41 && spriteSaber.position.y <67 && spriteSaber.position.y >61) {
        [spriteSaber stopAllActions];
    }
    if (spriteLancer.position.x <148 && spriteLancer.position.x >142 && spriteLancer.position.y <67 && spriteLancer.position.y >61) {
        [spriteLancer stopAllActions];
    }
    if (spriteArcher.position.x <203 && spriteArcher.position.x >197 && spriteArcher.position.y <67 && spriteArcher.position.y >62) {
        [spriteArcher stopAllActions];
    }

    if (!addInfo) {
        for (CCNode * sprite in _arraySup) {
            
            if (((sprite.position.y+sprite.contentSize.height * .3 > 208) && (sprite.position.y-sprite.contentSize.height * .3 < 208) && (sprite.position.x+sprite.contentSize.width * .3 > 358) && (sprite.position.x-sprite.contentSize.width * .3 < 358))) {
                CCLOG(@"got!!");
                supOn = YES;
                [sprite stopAllActions];


                lastSup = [[NSUserDefaults standardUserDefaults]integerForKey:@"Sup"];
                if([sprite isEqual:spriteSupLain])[[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"Sup"];
                if ([sprite isEqual:spriteSupSieg])[[NSUserDefaults standardUserDefaults]setInteger:1 forKey:@"Sup"];
                if ([sprite isEqual:spriteSupVa])[[NSUserDefaults standardUserDefaults]setInteger:2 forKey:@"Sup"];
                [[NSUserDefaults standardUserDefaults] synchronize];

                
            }
            if (supOn) {
                supOn = NO;
                switch (lastSup) {
                    case 0:{
                    //    [[OALSimpleAudio sharedInstance] playEffect:@"spiritUP.mp3" loop:NO];

                        spriteSupLain.position = ccp(242, 231);
                        id mov  = [CCActionMoveTo actionWithDuration:3.0f position:ccp(402, 64)];
                        [spriteSupLain runAction:mov];

                        break;
                    }
                    case 1:
                    {
                   //     [[OALSimpleAudio sharedInstance] playEffect:@"spiritUP.mp3" loop:NO];

                        spriteSupSieg.position = ccp(242, 231);
                        id mov  = [CCActionMoveTo actionWithDuration:3.0f position:ccp(350, 64)];
                        [spriteSupSieg runAction:mov];
                  }
                        break;
                    case 2:
                    {
                    //    [[OALSimpleAudio sharedInstance] playEffect:@"spiritUP.mp3" loop:NO];

                        spriteSupVa.position = ccp(242, 231);
                        id mov  = [CCActionMoveTo actionWithDuration:3.0f position:ccp(300, 64)];
                        [spriteSupVa runAction:mov];
                    }
                        break;
                        
                    default:
                        break;
                }
            }

        }
    }
    switch ([[NSUserDefaults standardUserDefaults]integerForKey:@"Sup"]) {
        case 0:
            spriteSupLain.position = ccp(358, 208);
            break;
        case 1:
            spriteSupSieg.position = ccp(358, 208);
            break;
        case 2:
            spriteSupVa.position  = ccp(358, 208);
            break;
        default:
            break;
    }
    if (spriteSupSieg.position.x <356 && spriteSupSieg.position.x >347 && spriteSupSieg.position.y <67 && spriteSupSieg.position.y >62) {
        [spriteSupSieg stopAllActions];
        CCLOG(@"stop sieg");
    }
    if (spriteSupVa.position.x <305 && spriteSupVa.position.x >296 && spriteSupVa.position.y <67 && spriteSupVa.position.y >62) {
        [spriteSupVa stopAllActions];
        CCLOG(@"stop va");
    }
    if (spriteSupLain.position.x <405 && spriteSupLain.position.x >399 && spriteSupLain.position.y <67 && spriteSupLain.position.y >62) {
        [spriteSupLain stopAllActions];
        CCLOG(@"stop lain");
    }

}
-(void) playerInfoLayerRemove  // 移除英靈資訊
{
    CCLOG(@"removeInfo");
    [self removeChild:playerInfo];
    addInfo = NO;


}
-(id) addLayerWithAnamation  // 英靈資訊動畫
{
    showLayer = [CCActionMoveTo actionWithDuration:0.2f position:ccp(self.contentSize.width/2,self.contentSize.height/2)];
    scaleLayer = [CCActionScaleTo actionWithDuration:0.2f scale:1];
    id seq = [CCActionSequence actionOne:showLayer two:scaleLayer];
    return seq;
}

-(void) playerInfoLayerAdd :(id)sprite  // 加入英靈資訊
{
    if ([sprite isEqualToString:@"0"]) {
        CCLOG(@"ADD PlayerInfoLayer!!");
        playerInfo = (PlayerInfoLayer *)[CCBReader load:@"PlayerInfoLayer"];
        playerInfo.position = spriteSaber.position;
        playerInfo.scale  = 0;
        playerInfo.delegate = self;
        [playerInfo setLabel:sprite];
        [self addChild:playerInfo z:100];
        [playerInfo runAction:[self addLayerWithAnamation]];
        addInfo = YES;
 //       [[OALSimpleAudio sharedInstance] playEffect:@"spriteTouch.mp3" loop:NO];

    }
    if ([sprite isEqualToString:@"1"]) {
        CCLOG(@"ADD PlayerInfoLayer!!");
        playerInfo = (PlayerInfoLayer *)[CCBReader load:@"PlayerInfoLayer"];
        playerInfo.position = spriteLancer.position;
        playerInfo.scale  = 0;
        playerInfo.delegate = self;
        [playerInfo setLabel:sprite];
        [self addChild:playerInfo z:100];
        [playerInfo runAction:[self addLayerWithAnamation]];
        addInfo = YES;
//        [[OALSimpleAudio sharedInstance] playEffect:@"spriteTouch.mp3" loop:NO];

    }
    if ([sprite isEqualToString:@"2"]) {
        CCLOG(@"ADD PlayerInfoLayer!!");
        playerInfo = (PlayerInfoLayer *)[CCBReader load:@"PlayerInfoLayer"];
        playerInfo.position = spriteArcher.position;
        playerInfo.scale  = 0;
        playerInfo.delegate = self;
            [playerInfo setLabel:sprite];
        [self addChild:playerInfo z:100];
        [playerInfo runAction:[self addLayerWithAnamation]];
        addInfo = YES;
   //     [[OALSimpleAudio sharedInstance] playEffect:@"spriteTouch.mp3" loop:NO];

    }
    if ([sprite isEqualToString:@"10"]) {
        CCLOG(@"ADD PlayerInfoLayer!!");
        playerInfo = (PlayerInfoLayer *)[CCBReader load:@"PlayerInfoLayer"];
        playerInfo.position = spriteSupLain.position;
        playerInfo.scale  = 0;
        playerInfo.delegate = self;
  
                [playerInfo setLabel:sprite];
        [self addChild:playerInfo z:100];
        [playerInfo runAction:[self addLayerWithAnamation]];
        addInfo = YES;
  //      [[OALSimpleAudio sharedInstance] playEffect:@"spriteTouch.mp3" loop:NO];

    }
    if ([sprite isEqualToString:@"11"]) {
        CCLOG(@"ADD PlayerInfoLayer!!");
        playerInfo = (PlayerInfoLayer *)[CCBReader load:@"PlayerInfoLayer"];
        playerInfo.position = spriteSupSieg.position;
        playerInfo.scale  = 0;
        playerInfo.delegate = self;
                [playerInfo setLabel:sprite];
        [self addChild:playerInfo z:100];
        [playerInfo runAction:[self addLayerWithAnamation]];
        addInfo = YES;
 //       [[OALSimpleAudio sharedInstance] playEffect:@"spriteTouch.mp3" loop:NO];

    }
    if ([sprite isEqualToString:@"12"]) {
        CCLOG(@"ADD PlayerInfoLayer!!");
        playerInfo = (PlayerInfoLayer *)[CCBReader load:@"PlayerInfoLayer"];
        playerInfo.position = spriteSupVa.position;
        playerInfo.scale  = 0;
        playerInfo.delegate = self;
                [playerInfo setLabel:sprite];
        [self addChild:playerInfo z:100];
        [playerInfo runAction:[self addLayerWithAnamation]];
        addInfo = YES;
 //       [[OALSimpleAudio sharedInstance] playEffect:@"spriteTouch.mp3" loop:NO];

    }
}
-(void) block :(id)sender
{
    //important can't delet
}
-(void)onExit {
    [oal  stopEverything];
    [oal stopAllEffects];
    [oal unloadAllEffects];
    [self stopAllActions];
    [self unscheduleAllSelectors];
    [self removeAllChildrenWithCleanup:YES];

 //   [[OALSimpleAudio sharedInstance] stopAllEffects];
  //  [[OALSimpleAudio sharedInstance]unloadAllEffects];
    CCLOG(@"Onexit");
    [super onExit];
}

@end
