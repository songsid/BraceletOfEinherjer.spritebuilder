//
//  HPMPInfo.m
//  NUTheNord
//
//  Created by Sid on 2014/4/12.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import "HPMPInfo.h"

@implementation HPMPInfo
@synthesize HP,MP;
-(void) didLoadFromCCB
{
  //  [self initHPMP];
    if ([[NSUserDefaults standardUserDefaults]integerForKey:@"Sup"] ==1) {
        MP = 0;
        HP = 13;
        _hptotal.string  = [NSString stringWithFormat:@"/13"];
        MPNum.string = [NSString stringWithFormat:@"%d",MP];
        HPNum.string = [NSString stringWithFormat:@"%d",HP];
        MPLine.scaleX = 0.01f;
        HPLine.scaleX = 1;
    }else{
        MP = 0;
        HP = 10;
        MPNum.string = [NSString stringWithFormat:@"%d",MP];
        HPNum.string = [NSString stringWithFormat:@"%d",HP];
        MPLine.scaleX = 0.01f;
        HPLine.scaleX = 1;
    }
}
-(void) hpDecrease :(int) damage
{
    if ([[NSUserDefaults standardUserDefaults]integerForKey:@"Sup"] == 1) {
        HP = HP-damage;
        if (HP<0) {
            HP = 0;
        }
        HPNum.string = [NSString stringWithFormat:@"%d ",HP ];
        float hpl = (float)HP/13;
        HPLine.scaleX = hpl;
        CCLOG(@"HPDECREASE HERE! HP:%d %f %f",HP,(float) HP/13,HPLine.scaleY);
    }else{
        HP = HP-damage;
        if (HP<0) {
        HP = 0;
    }
    HPNum.string = [NSString stringWithFormat:@"%d ",HP ];
    float hpl = (float)HP/10;
    HPLine.scaleX = hpl;
    CCLOG(@"HPDECREASE HERE! HP:%d %f %f",HP,(float) HP/10,HPLine.scaleY);
    }
}
-(void) hpIncrease :(int) plus
{}
-(void) mpDecrease :(int) count
{
    if (MP>0) {
        MP = MP -count;
        MPNum.string = [NSString stringWithFormat:@"%d",MP];
        float mpl = (float)MP/10;
        MPLine.scaleX = mpl;
    }
}
-(void) mpIncrease :(int) destance
{
    if (MP<10) {
    
    MP = MP +destance;
    MPNum.string = [NSString stringWithFormat:@"%d",MP];
    float mpl = (float)MP/10;
    MPLine.scaleX = mpl;
    }
}
-(void) initHPMP
{
     if ([[NSUserDefaults standardUserDefaults]integerForKey:@"Sup"] ==1)
     {
         HP =13;
         MP =0;
         HPNum.string = [NSString stringWithFormat:@"%d ",HP ];
         float hpl = (float)HP/13;
         HPLine.scaleX = hpl;
         
         MPNum.string = [NSString stringWithFormat:@"%d",MP];
         float mpl = (float)MP/10;
         MPLine.scaleX = mpl;
     }else{
         
    HP =10;
    MP =0;
    HPNum.string = [NSString stringWithFormat:@"%d ",HP ];
    float hpl = (float)HP/10;
    HPLine.scaleX = hpl;
    
    MPNum.string = [NSString stringWithFormat:@"%d",MP];
    float mpl = (float)MP/10;
    MPLine.scaleX = mpl;
     }
}
-(void) update:(CCTime)delta
{

}
-(void) opacity:(BOOL)op
{
    if (op) {
        _bg.opacity = 0.4f;
        HPLine.opacity =0.4f;
        MPLine.opacity = 0.4f;
    }else
    {
        _bg.opacity = 1;
        HPLine.opacity =1;
        MPLine.opacity = 1;
    }
}

////---封印////////////
-(void) popLevelScene{}
////---封印////////////
@end
