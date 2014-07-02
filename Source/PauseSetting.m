//
//  PauseSetting.m
//  NUTheNord
//
//  Created by Sid on 2014/5/4.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import "PauseSetting.h"

@implementation PauseSetting

-(void) didLoadFromCCB
{
    self.userInteractionEnabled = YES;
}
-(void) closePause:(id)sender
{
    [self.delegate closePause];
}
-(void) leftLevel:(id)sender
{
    CCAlertView *av = [CCAlertView alloc];
    av = (CCAlertView* )[CCBReader load:@"CCAlertView"];
    [av initWithTitle:@"遊戲提醒" message:@"是否離開本關卡？" delegate:self cancelButtonTitle:@"取消" otherButtonTitle:@"確定"];
    [av showAV];
    
    _close.enabled = NO;
    _left.enabled = NO;
    _restart.enabled = NO;
    reloadGame = NO;
}
-(void) isRestart:(id) sender
{
    CCAlertView *av = [CCAlertView alloc];
    av = (CCAlertView* )[CCBReader load:@"CCAlertView"];
    [av initWithTitle:@" " message:@"是否重新開始本關卡？" delegate:self cancelButtonTitle:@"取消" otherButtonTitle:@"確定"];
    [av showAV];
    
    _close.enabled = NO;
    _left.enabled = NO;
    _restart.enabled = NO;
    reloadGame = YES;
}
- (void) CCAlertView:(CCNode *)alertView indexSelected:(int)index {
    if (index == 0) {
        CCLOG(@"CANCEL Pressed");
        _close.enabled = YES;
        _left.enabled = YES;
        _restart.enabled = YES;
    }else if (index == 1) {
        CCLOG(@"OK Pressed");
        if (!reloadGame) {
        [self scheduleBlock:^(CCTimer * timer){
            [self.delegate popLevelScene];
/*            _close.enabled = YES;
            _left.enabled = YES;
            _restart.enabled =YES; */
        } delay:0.1f];
        }else{
            [self.delegate reloadGame];
            _close.enabled = YES;
            _left.enabled = YES;
            _restart.enabled =YES;
            [self removeFromParent];
        }
    }
}
@end
