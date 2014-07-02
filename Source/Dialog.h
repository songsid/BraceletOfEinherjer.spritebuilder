//
//  Dialog.h
//  NUTheNord
//
//  Created by Sid on 2014/4/22.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//
@protocol DialogDelegate <NSObject>

-(void) removeDialog;

@end
#import "CCNode.h"

@interface Dialog : CCNode
{
    CCLabelTTF * _dialogtext;
    int dialogInt;
    BOOL userActInt;
    CCNode * _npc;
    CCNode * _zero;
    CCNode * _blueDia;
    CCNode * _sciDia;
}

@property (nonatomic,weak) id<DialogDelegate> delegate;
@end
