//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Sid on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"

@implementation MainScene
-(void) didLoadFromCCB
{
    _mainScrollView.anchorPoint = ccp(0,0);
    _mainScrollView.position = ccp(0, 0);
    
    // ipad iphone 判斷修改解析度
    if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad){ self.scale = 1.07;}
  
    // leagueScene 退出至mainScene 用 rebuid == rebuilMainScene
    if ([[NSUserDefaults standardUserDefaults]integerForKey:@"Rebuild"] ==1) {
        MainMenuLayer * main =  (MainMenuLayer *)[CCBReader load:@"MainMenuLayer"];
        _mainScrollView.contentNode = main;
        main.delegate = self;
    }else{
        // 播放 點選進入遊戲 或 首次進場動畫
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"SeePre"]) {
        FirstTimeIntroLayer * first = (FirstTimeIntroLayer *) [CCBReader load:@"FirstTimeIntroLayer"];
        first.delegate = self;
        _mainScrollView.contentNode = first;
        }else{
            SkipIntoLayer * skip = (SkipIntoLayer *)[CCBReader load:@"SkipIntoLayer"];
            skip.delegate = self;
            _mainScrollView.contentNode = skip;
    }
    }
    
    // 預設值
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"SeePre"];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Rebuild"];
    [[NSUserDefaults standardUserDefaults]synchronize];
   
}
-(void) firstTimeEnd //進場動畫 第二段
{
    FirstTimeIntroTwoLayer * two = (FirstTimeIntroTwoLayer *) [CCBReader load:@"FirstTimeIntroTwoLayer"];
    two.delegate = self;
    _mainScrollView.contentNode = two;

}
-(void) firstTimeIntro //left FirstTimeIntro into LeagueScene
{
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"SeePre"] ){
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"SeePre"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [[CCDirector sharedDirector]popScene];
        }else{
                MainMenuLayer * menu = (MainMenuLayer *) [CCBReader load:@"MainMenuLayer"];
                menu.delegate = self;
                _mainScrollView.contentNode = menu;
                CCLOG(@"skip!!!!");
                [self pushLeagueScene];
    }
}
-(void) selectFirstTime // 點選進場動畫 mainScene 重新設置為 進場動畫 layer
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"SeePre"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    MainScene * main = (MainScene *)[CCBReader loadAsScene:@"MainScene"];

    [[CCDirector sharedDirector] replaceScene:main];
   /* FirstTimeIntroLayer * first = (FirstTimeIntroLayer *) [CCBReader load:@"FirstTimeIntroLayer"];
    first.delegate = main;
    main.mainScrollView.contentNode = first;*/
}
-(void) skipInto //點擊進入遊戲
{
    NSString *firstIntro = [[NSUserDefaults standardUserDefaults]objectForKey:@"FirstTime"];
    
    if (!firstIntro) {
        FirstTimeIntroLayer * first = (FirstTimeIntroLayer *) [CCBReader load:@"FirstTimeIntroLayer"];
        first.delegate = self;
        _mainScrollView.contentNode = first;
    }else{
    
    MainMenuLayer * menu = (MainMenuLayer *) [CCBReader load:@"MainMenuLayer"];
    menu.delegate = self;
    _mainScrollView.contentNode = menu;
    CCLOG(@"skip!!!!");
    }
    
}
-(void) pushPlayerInfoScene //推出英靈選單
{
  //  [[OALSimpleAudio sharedInstance]unloadAllEffects];
    _playerInfo = (PlayerInfoScene * )[CCBReader loadAsScene:@"PlayerInfoScene"];
    CCTransition *trans = [CCTransition transitionPushWithDirection:1 duration:0.2f];

    [[CCDirector sharedDirector]replaceScene:_playerInfo withTransition:trans];
}

-(void) pushLeagueScene //推出任務選單
{
    _league = (LeagueScene * )[CCBReader loadAsScene:@"LeagueScene"];
    CCTransition *trans = [CCTransition transitionPushWithDirection:1 duration:0.2f];
    [[CCDirector sharedDirector]replaceScene:_league withTransition:trans];
    
}
@end
