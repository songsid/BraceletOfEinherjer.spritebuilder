//
//  FailCount.m
//  NUTheNord
//
//  Created by Sid on 2014/5/12.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import "FailCount.h"

@implementation FailCount
-(void) didLoadFromCCB
{
    self.userInteractionEnabled = YES;
}

-(void) leftLevel:(id)sender
{
    CCAlertView *av = [CCAlertView alloc];
    av = (CCAlertView* )[CCBReader load:@"CCAlertView"];
    [av initWithTitle:@"遊戲提醒" message:@"是否離開本關卡？" delegate:self cancelButtonTitle:@"取消" otherButtonTitle:@"確定"];
    [av showAV];
    
    _restart.enabled = NO;
    _leftLevel.enabled = NO;
    reloadGame = NO;
}

-(void) isRestart :(id) sender
{
    CCAlertView *av = [CCAlertView alloc];
    av = (CCAlertView* )[CCBReader load:@"CCAlertView"];
    [av initWithTitle:@" " message:@"是否重新開始本關卡？" delegate:self cancelButtonTitle:@"取消" otherButtonTitle:@"確定"];
    [av showAV];
    
    _restart.enabled = NO;
    _leftLevel.enabled = NO;
    reloadGame = YES;

}
- (void) CCAlertView:(CCNode *)alertView indexSelected:(int)index {
    if (index == 0) {
        CCLOG(@"CANCEL Pressed");
        _leftLevel.enabled = YES;
        _restart.enabled = YES;
    }else if (index == 1) {
        CCLOG(@"OK Pressed");
        [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"DialogInt"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        if (!reloadGame) {
            FailCount * fc = self;
            [self scheduleBlock:^(CCTimer * timer){
                [fc.delegate popLevelScene];
           /*     _leftLevel.enabled = YES;
                _restart.enabled =YES;*/
            } delay:0.1f];
        }else{
            [self.delegate reloadGame];
            _leftLevel.enabled = YES;
            _restart.enabled =YES;
            [self removeFromParent];
        }
    }
}
@end
