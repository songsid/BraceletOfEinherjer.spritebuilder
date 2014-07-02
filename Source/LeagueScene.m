//
//  LeagueScene.m
//  NUTheNord
//
//  Created by Sid on 2014/3/13.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import "LeagueScene.h"
#import "AppDelegate.h"
@implementation LeagueScene
-(void) didLoadFromCCB
{
    _enterFire.visible = NO;
    _enter.zOrder = _enterFire.zOrder +1;
    blockPop = NO;
    _block.visible = NO;
    _block.zOrder = 10;
    _leagueSceneScrollView.anchorPoint = ccp(0, 0);
    _leagueSceneScrollView.position = ccp(0, 0);
    if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
 
        self.scale = 1.07;
    }

    self.userInteractionEnabled = TRUE;
    LeagueLayer * league = (LeagueLayer *) [CCBReader load:@"LeagueMapLayer"];
    league.delegate = self;
    _leagueSceneScrollView.contentNode = league;
    _cancel.zOrder = 100;
    _enter.zOrder = 100;
    //
    oal = [OALSimpleAudio sharedInstance];

    
    
}

-(void) popLeagueScene // 離開任務選單
{
    if (!blockPop) {
        blockPop = YES;
        [[OALSimpleAudio sharedInstance]unloadAllEffects];
  /*
         AppController *appDelegate = (AppController *)[[UIApplication sharedApplication] delegate];
         [appDelegate performSelector:@selector(rebuildMainScene) withObject:nil afterDelay:0.2];
        [[CCDirector sharedDirector] popScene];
    */
        [[NSUserDefaults standardUserDefaults]setInteger:1 forKey:@"Rebuild"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    CCTransition * trans = [CCTransition transitionFadeWithDuration:0.2];
//        [[CCDirector sharedDirector]popSceneWithTransition:trans];
    CCLOG(@"popleague!!!!!");
        CCScene * sce = [CCBReader loadAsScene:@"MainScene"];
        [[CCDirector sharedDirector]replaceScene:sce withTransition:trans];
    }
}
-(void) pushLevel // 進入遊戲關卡
{
    [oal stopAllEffects];
  //  [[OALSimpleAudio sharedInstance]unloadAllEffects];
   // _level = [CCBReader loadAsScene:@"LevelScene"];
        CCTransition *trans = [CCTransition transitionPushWithDirection:1 duration:0.2f];
        [[CCDirector sharedDirector]replaceScene:[CCBReader loadAsScene:@"LevelScene"] withTransition:trans];
  
}
/*
-(void) intoLevelOrNot
{
    
}
*/
-(void) controlSlide:(int)slide
{
    
    
    if (slide%2) {
        [self.userObject runAnimationsForSequenceNamed:@"Slide"];
    }else{
        [self.userObject runAnimationsForSequenceNamed:@"BackSlide"];
    }
}
-(void) isPopLeagueScene:(id)sender
{
    if (!showInfo) {
        _block.visible = YES;
        [oal stopAllEffects];
        [self popLeagueScene];
        
      //  [[OALSimpleAudio sharedInstance] playEffect:@"d5.mp3" loop:YES];
    }else{
        showInfo = NO;
        _enterFire.visible = NO;
        [self removeChild:leagueInfo cleanup:YES];
    }
}
-(void) showLeagueInfo:(CGPoint)x :(int)level
{
    _enterFire.visible = YES;
    levelCount = level;
    leagueInfo = (LeagueInfo *)[CCBReader load:@"LeagueInfo"];
    leagueInfo.position = x;
    leagueInfo.scale = 0.1f;
    [self addChild:leagueInfo z:0];
    id scale = [CCActionScaleTo actionWithDuration:0.2f scaleX:0.7f scaleY:0.7f];
    id mov = [CCActionMoveTo actionWithDuration:0.2f position:ccp(_leagueSceneScrollView.contentSize.width *0.5,_leagueSceneScrollView.contentSize.height *0.5 )];
    [leagueInfo runAction:scale];
    [leagueInfo runAction:mov];
    showInfo = YES;
    switch (level) {
        case 0:
            [leagueInfo setMissionString:@"首次戰鬥！"];
            [leagueInfo setMissionDetailString:@"難易度：★★★☆☆\n\n本關卡內將會教導如何使用英靈戰鬥"];
            break;
        case 1:
             [leagueInfo setMissionString:@"前方的道路─西北方礦坑"];
             [leagueInfo setMissionDetailString:@"難易度：★★★★☆\n\n為了前往拯救鄰鎮的同胞，\n礦坑是唯一的道路。"];

            break;
            
        default:
            break;
    }
    
}
-(void) isEnter:(id)sender
{
    if (leagueInfo.parent) {
        switch (levelCount) {
            case 0:
                [self appearAlertView];
                break;
            
            case 1:
                [self appearAlertView];
                break;
                
            default:
                break;
        }
    }
}
-(void) block:(id) sender
{
    CCLOG(@"block!");
    //important !
}
/////////
-(id) initWithTitle:(NSString*)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle{return 0;}
-(void) showAV{}
-(void) appearAlertView
{
    

    CCAlertView *av = [CCAlertView alloc];
    av = (CCAlertView* )[CCBReader load:@"CCAlertView"];
    [av initWithTitle:@"  " message:@"是否進入關卡？" delegate:self cancelButtonTitle:@"否" otherButtonTitle:@"是"];
    
                           
    
    [av showAV];
        
        CCLOG(@"self scheduleblock");

    
}
//set the Ok and Cancel of CCAlertView
- (void) CCAlertView:(CCNode *)alertView indexSelected:(int)index {
    if (index == 0) {
        CCLOG(@"CANCEL Pressed");

        
        
    }else if (index == 1) {
        CCLOG(@"OK Pressed");
        
        [self pushLevel];
        
    }
}
////////

-(void) onExit
{
    [oal stopAllEffects];
    [oal unloadAllEffects];
    [self stopAllActions];
    
    [self removeAllChildrenWithCleanup:YES];

    [self unscheduleAllSelectors];
    
    CCLOG(@"oneXit");
    [super onExit];
    CCLOG(@"onExIT");
}
@end
