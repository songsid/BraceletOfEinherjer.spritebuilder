//
//  PlayerInfoLayer.m
//  NUTheNord
//
//  Created by Sid on 2014/3/13.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import "PlayerInfoLayer.h"

@implementation PlayerInfoLayer
-(void) didLoadFromCCB
{
    self.userInteractionEnabled = YES;
    _bgButton.label.opacity = 0.5;


}

-(void) update:(CCTime)delta
{
    
}
-(void) leftPlayerInfo:(id)sender // 移除英靈資訊
{
    [self.delegate playerInfoLayerRemove];
}

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    
}
-(void) touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
}
-(void) spiritSetting : (int) num
{
    _saber.visible = NO;
    _lancer.visible = NO;
    _archer.visible = NO;
    _supLi.visible = NO;
    _supSieg.visible = NO;
    _supVa.visible = NO;
    
    switch (num) {
        case 0:
            _saber.visible = YES;
            break;
        case 1:
            _lancer.visible = YES;
            break;
        case 2:
            _archer.visible = YES;
            break;
        case 10:
            _supLi.visible = YES;
            break;
        case 11:
            _supSieg.visible = YES;
            break;
        case 12:
            _supVa.visible = YES;
            break;
        default:
            break;
    }
}

-(void) setLabel:(id)name
{
    if ([name isEqualToString:@"0"]) {
        _spirit.string = @"亞瑟王";
        _class.string = @"職業：劍士";
        _attack.string = @"攻擊：攻擊力3點，消耗3點MP。";
        _skill.string = @"技能：破炎斬";
        [self spiritSetting:0];
      //  _img.spriteFrame = [CCSprite spriteWithSpriteFrame:img];
    }
    if ([name isEqualToString:@"1"]) {
        _spirit.string = @"楊再興";
        _class.string = @"職業：槍兵";
        _attack.string = @"攻擊：攻擊力2點，消耗3點MP。";
        _skill.string = @"技能：怒雷之槍";
        [self spiritSetting:1];
    }
    if ([name isEqualToString:@"2"]) {
        _spirit.string = @"豐鍬";
        _class.string = @"職業：弓箭手";
        _attack.string = @"攻擊：攻擊力1點，消耗3點MP。";
        _skill.string = @"技能：風刃矢";
        [self spiritSetting:2];
    }
    if ([name isEqualToString:@"10"]) {
        _spirit.string = @"聖靈之懲憶";
        _class.string = @"職業：輔助";
        _attack.string = @"輕盈之躍：裝備後提昇跳躍高度。";
        _skill.string = @"技能：無";
        [self spiritSetting:10];

    }
    if ([name isEqualToString:@"11"]) {
        _spirit.string = @"齊格飛";
        _class.string = @"職業：輔助";
        _attack.string = @"龍血護體：裝備後基本HP上升3點。";
        _skill.string = @"技能：無";
        [self spiritSetting:11];

    }
    if ([name isEqualToString:@"12"]) {
        _spirit.string = @"維納莫寧";
        _class.string = @"職業：輔助";
        _attack.string = @"維納莫寧之詠唱：裝備後MP回復率上升。";
        _skill.string = @"技能：無";
        [self spiritSetting:12];

    }
}
-(void)onExit {
    [self stopAllActions];
    [self unscheduleAllSelectors];
    [self removeAllChildrenWithCleanup:YES];
    CCLOG(@"Onexit");
    [super onExit];
}
@end
