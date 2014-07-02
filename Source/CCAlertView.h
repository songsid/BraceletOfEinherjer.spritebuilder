//
//  CCAlertView.h
//  CCAlertView
//
//  Created by Sid on 2014/3/30.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CCAlertviewDelegate <NSObject>
- (void) CCAlertView:(CCNode*)alertView indexSelected:(int)index;
@end

@interface CCAlertView : CCNode
{
    CCNode * _alertView;
    CCButton * _BG;
    CCButton * _ok;
    CCButton * _cancel;
    CCLayoutBox * _alertMenu;
    CCLabelTTF * _messageLabel;
    CCLabelTTF * _titleLabel;
    
    id fadeIn1;
    id fadeIn2;
    id fadeInT;
    id fadeIn;
    id scale1;
    id scale2;
    id scale3;
    id pulse;
}

@property (nonatomic, retain) id <CCAlertviewDelegate> _delegate;
-(void) initWithTitle:(NSString*)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle;
-(void) showAV;




@end
