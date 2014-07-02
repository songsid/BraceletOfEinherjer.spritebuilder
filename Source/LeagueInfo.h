//
//  LeagueInfo.h
//  NUTheNord
//
//  Created by Sid on 2014/5/26.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface LeagueInfo : CCNode
{
    CCLabelTTF * _mission;
    CCLabelTTF * _missionDetail;
    OALSimpleAudio *oal;
}

-(void) setMissionString :(NSString *) str;
-(void) setMissionDetailString :(NSString *) str;
@end
