//
//  CCAlertView.m
//  CCAlertView
//
//  Created by Sid on 2014/3/30.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import "CCAlertView.h"

@implementation CCAlertView
-(void) didLoadFromCCB
{
    self.userInteractionEnabled = YES;
    fadeIn1 = [CCActionFadeTo actionWithDuration:0.01f opacity:0.0f];
    fadeIn2 = [CCActionFadeTo actionWithDuration:0.3f opacity:0.9f];
    fadeInT = [CCActionSequence actions: fadeIn1,fadeIn2,nil];
    fadeIn = [CCActionFadeIn actionWithDuration:0.1];
    scale1 = [CCActionSpawn actions:fadeIn, [CCActionScaleTo actionWithDuration:0.15 scale:1.1], nil];
    scale2 = [CCActionScaleTo actionWithDuration:0.1 scale:0.9];
    scale3 = [CCActionScaleTo actionWithDuration:0.05 scale:1.0];
    pulse = [CCActionSequence actions:scale1, scale2, scale3, nil];
}


-(void) initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle
{CCLOG(@"\n initCCAlertView! \n");
    {
        self._delegate = delegate;
        
       // BOOL isIPAD = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
 //       CGSize views = CGSizeMake([CCDirector sharedDirector].viewSize.width, [CCDirector sharedDirector].viewSize.height);
//        CGSize size = CGSizeMake(287, 139);
//        NSString *fontStyle = @"HelveticaNeue-Bold";
      //  CCSpriteFrame *altImg = [CCSpriteFrame frameWithImageNamed:@"redalertview.png"]; //if (isIPAD) altImg =[CCSpriteFrame frameWithImageNamed: @"redalertview-hd.png"];
        
 //       CCSpriteFrame *rlb = [CCSpriteFrame frameWithImageNamed:@"NUCL_R.png"]; //if (isIPAD) rlb =[CCSpriteFrame frameWithImageNamed:@"redlightButton-hd.png"];
        
//        CCSpriteFrame *rdb =[CCSpriteFrame frameWithImageNamed:@"NUCD_R.png"]; //if (isIPAD) rdb =[CCSpriteFrame frameWithImageNamed:@"reddarkButton-hd.png"];
 //       float fnt1 = 18, fnt2 = 14;
       // float padding = 10; // distance between buttons
 //       float menuPos = 30; // buttons vertical alignment offset
        float titleHtDif = 20; //height of title label
        float msgHtDif = 50; //height of messgae label
  //      _BG = [CCButton buttonWithTitle:@"███" fontName:@"新細明體" fontSize:500.0f];
   //     [_BG setTarget:self selector:@selector(empty:)];
        _BG.color = [CCColor colorWithWhite:0.0 alpha:0.6];
   //     _BG.enabled = NO;
   //     _BG.label.opacity = 0.5f;
        _BG.anchorPoint = ccp(0.5, 0.5);
        _BG.position = ccp(0, 0);
        _BG.contentSize = [CCDirector sharedDirector].viewSize;
        //
     /*
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
        [[[CCDirector sharedDirector] view] addGestureRecognizer:recognizer];
       */ //
        
     //   [self addChild:_BG z:0];
        
        _BG.userInteractionEnabled = YES;
        
	//	_alertViewSprite = [CCSprite spriteWithImageNamed:[NSString stringWithFormat:@"NUAlertView.png"]];
        
        _alertView.opacity = 1;
        _alertView.anchorPoint = ccp(0.5, 0.5);
        _alertView.position = ccp(_BG.position.x, _BG.position.y);

        
		// 287X139
		
		self.anchorPoint = ccp(0.5,0.5);
        
        if (title == nil || [title isEqualToString:@""]){
            title = @"Alert Title";
        }
        if (message == nil || [message isEqualToString:@""]){
            message = @"Message Here";
        }
        if (otherButtonTitle == nil || [otherButtonTitle isEqualToString:@""]){
            otherButtonTitle = @"";
        }
        if (cancelButtonTitle == nil || [cancelButtonTitle isEqualToString:@""]){
            cancelButtonTitle = @"OK";
        }
    /*
        CCButton * OK = [CCButton buttonWithTitle:@"" spriteFrame:rlb];
        OK.scale = 0.7f;
        [OK setTarget:self selector:@selector(otherButtonPressed:)];
        //       CCMenuItemImage *OK = [CCMenuItemImage itemWithNormalImage:rdb selectedImage:rlb target:self selector:@selector(otherButtonPressed:)];
        CCButton * Cancel = [CCButton buttonWithTitle:@"" spriteFrame:rdb];
        Cancel.scale = 0.7f;
        [Cancel setTarget:self selector:@selector(cancelButtonPressed:)];
        //		CCMenuItemImage *Cancel = [CCMenuItemImage itemWithNormalImage:rdb selectedImage:rlb target:self selector:@selector(cancelButtonPressed:)];
        
        CCLayoutBox * alertMenu = [[CCLayoutBox alloc]init];
        alertMenu.direction = CCLayoutBoxDirectionHorizontal;
        [alertMenu addChild:OK];
        [alertMenu addChild:Cancel];
        alertMenu.anchorPoint = ccp(0.5f,0.5f);
     */
        //        CCMenu *alertMenu;
        /*
         if (otherButtonTitle == nil || [otherButtonTitle isEqualToString:@""]){
         alertMenu = [CCLayoutBox menuWithItems
         :Cancel, nil];
         }else{
         alertMenu = [CCMenu menuWithItems:OK, Cancel, nil];
         [alertMenu alignItemsHorizontallyWithPadding:padding];
         }
         */
		//_alertMenu.position = ccp(size.width * .5, (size.height * .5) - menuPos);
		//[_alertViewSprite addChild:_alertMenu];
		
	//	CCLabelTTF *TitleLabel = [CCLabelTTF labelWithString:title fontName:fontStyle fontSize:fnt1];
        
     
        _titleLabel.string = title;
		_titleLabel.position = ccp(_alertView.contentSize.width * .5, _alertView.contentSize.height-titleHtDif);
	//	[_alertViewSprite addChild:TitleLabel];
        
    //    CCLabelTTF *MessageLabel = [CCLabelTTF labelWithString:message fontName:fontStyle fontSize:fnt2 ];// dimensions:CGSizeMake(_alertViewSprite.contentSize.width - 10, fnt2*3) hAlignment:kCCTextAlignmentCenter vAlignment:kCCVerticalTextAlignmentCenter lineBreakMode:kCCLineBreakModeWordWrap];
        _messageLabel.string = message;
		_messageLabel.position = ccp(_alertView.contentSize.width * .5, _alertView.contentSize.height-msgHtDif);
	//	[_alertViewSprite addChild:MessageLabel];
		
	//	CCLabelTTF *OKlabel = [CCLabelTTF labelWithString:otherButtonTitle fontName:fontStyle fontSize:fnt1];
        _ok.label.string = otherButtonTitle;
		//_ok.label.position = ccp(_ok.contentSize.width * .5, _ok.contentSize.height * .5);
	//	[OK addChild:OKlabel];
		
	//	CCLabelTTF *cancellabel = [CCLabelTTF labelWithString:cancelButtonTitle fontName:fontStyle fontSize:fnt1];
        _cancel.label.string = cancelButtonTitle;
		//_cancel.label.position = ccp(_cancel.contentSize.width * .5, _cancel.contentSize.height * .5);
	//	[Cancel addChild:cancellabel];
		

        

	}
	

    
}

-(void)showAV {
    CCLOG(@"\n RunShowAV \n");
    [self stopAllActions];
    CCScene *scene = [[CCDirector sharedDirector] runningScene];
    CGSize size = [[CCDirector sharedDirector]viewSize];
    self.position = ccp(size.width * .5, size.height * .5);
   
    [scene addChild:self z:1];
    

    CCLOG(@"%@",fadeInT);
    //[_BG runAction:fadeInT];
    //[_alertViewSprite runAction:pulse];
    

 //   [[OALSimpleAudio sharedInstance] playEffect:@"alert.caf"];
}

-(void) otherButtonPressed:(id) sender {
    [self._delegate CCAlertView:self indexSelected:1];

    
    CCScene *scene = [[CCDirector sharedDirector] runningScene];
    [scene removeChild:self cleanup:YES];
}
-(void) cancelButtonPressed:(id) sender {
	[self._delegate CCAlertView:self indexSelected:0];

    CCScene *scene = [[CCDirector sharedDirector] runningScene];
    [scene removeChild:self cleanup:YES];
}
-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CCLOG(@"AlertViewtouchbegin");
}
-(void) empty:(id)sender
{
    CCLOG(@"alertViewtb");
}
@end
