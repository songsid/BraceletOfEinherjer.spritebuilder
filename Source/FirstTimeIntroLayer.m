//
//  FirstTimeIntroLayer.m
//  NUTheNord
//
//  Created by Sid on 2014/3/15.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import "FirstTimeIntroLayer.h"

@implementation FirstTimeIntroLayer
-(void) didLoadFromCCB
{
  //  [[OALSimpleAudio sharedInstance]unloadAllEffects];

    end = YES;
    _load.visible = NO;
    self.userInteractionEnabled = YES;
    //first time key
    [[NSUserDefaults standardUserDefaults] setObject:@"Intro"  forKey:@"FirstTime" ];
    //spirit default
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Spirit"];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Sup"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    oal = [OALSimpleAudio sharedInstance];
    [oal stopAllEffects];
    [oal playEffect:@"firstTimeMusic.caf" loop:YES];
/*
    _talk.anchorPoint = ccp(0.5, 0.5);
    _talk.position = ccp(240, 160);

   // _talk.string = [NSString stringWithFormat:@"你好"];
    labelCount = 0;
*/
}
-(void) isSkip:(id)sender
{
    _load.visible = YES;

}
-(void) update:(CCTime)delta
{
    
    if (_load.visible == YES ) {
        [self.delegate firstTimeEnd];
    }
    CCLOG(@"_load.visible = %hhd",_load.visible);
    
    
    switch (labelCount) { 
        case 1:
            _talk.string = [NSString stringWithFormat:@"1"];
            break;
        case 2:
            _talk.string = [NSString stringWithFormat:@"2"];
            break;
        case 3:
            _talk.string = [NSString stringWithFormat:@"3"];
            break;
        case 4:
            _talk.string = [NSString stringWithFormat:@"4"];
            break;
        case 5:
            _talk.string = [NSString stringWithFormat:@"5"];
            break;
        case 6:
            _talk.string = [NSString stringWithFormat:@"6"];
            break;
        case 7:
            _talk.string = [NSString stringWithFormat:@"7"];
            break;
        case 8:
            _talk.string = [NSString stringWithFormat:@"8"];
            break;
        case 9:
            _talk.string = [NSString stringWithFormat:@"9"];
            break;
        case 10:
            _talk.string = [NSString stringWithFormat:@"10"];
            break;
        case 11:
            _talk.string = [NSString stringWithFormat:@"11"];
            break;
        
        case 12:
            
            [self.delegate firstTimeIntro];
            
            break;
        default:
            break;
    }
    
}

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{

    //labelCount = labelCount + 1;
}

-(void)onExit {
    [self stopAllActions];
    [self unscheduleAllSelectors];
    [self removeAllChildrenWithCleanup:YES];
    [oal stopAllEffects];
    [oal unloadAllEffects];
    CCLOG(@"Onexit");
    [super onExit];
}
@end
