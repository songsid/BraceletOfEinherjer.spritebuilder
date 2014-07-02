//
//  LeagueInfo.m
//  NUTheNord
//
//  Created by Sid on 2014/5/26.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import "LeagueInfo.h"

@implementation LeagueInfo
-(void) didLoadFromCCB
{
    oal = [OALSimpleAudio sharedInstance];
    [oal stopAllEffects];
    [oal playEffect:@"prepareMusic.caf" loop:YES];

}

-(void) setMissionString :(NSString *) str
{
    _mission.string = str;
}
-(void) setMissionDetailString :(NSString *) str
{
    _missionDetail.string = str;
}

@end
