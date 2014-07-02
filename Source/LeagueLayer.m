//
//  LeagueLayer.m
//  NUTheNord
//
//  Created by Sid on 2014/3/13.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import "LeagueLayer.h"
#define kCCTestMenuItemHeight 30
#define kCCUITestHeaderHeight 44
@implementation LeagueLayer

-(void) didLoadFromCCB
{
    self.userInteractionEnabled = TRUE;
/*    tableView = [[CCTableView alloc] init];
    tableView.contentSizeType = CCSizeTypeMake(CCSizeUnitNormalized, CCSizeUnitInsetPoints);
    tableView.contentSize = CGSizeMake(0.3f,90.0f);
    tableView.rowHeight = kCCTestMenuItemHeight;
    tableView.dataSource = self;
    tableView.anchorPoint = ccp(0, 1);
    tableView.position = ccp(243 ,300 );
 
    _levels = nil;
    _levelNum = 0;
    [self addChild:tableView z:1];

    [self setBlockButton:YES];
    
    CCLOG(@"didloadfromccb");
  *//*  _isSelectLevel0.block = ^(id sender)
    {
        
        CCLOG(@"block");
    };*/
    
    //
  //  slide = 1;
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"SelectLevel"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    oal = [OALSimpleAudio sharedInstance];
    [oal stopAllEffects];
    [oal playEffect:@"mapMusic.caf" loop:YES];
}


/*
-(void) setTableView:(CCTableView *)tableViewer
{
    tableViewer.contentSizeType = CCSizeTypeMake(CCSizeUnitNormalized, CCSizeUnitInsetPoints);
    tableViewer.contentSize = CGSizeMake(0.3f,90.0f);
    tableViewer.rowHeight = kCCTestMenuItemHeight;
    tableViewer.dataSource = self;
    tableViewer.anchorPoint = ccp(0, 1);
    tableViewer.position = ccp(243 ,300 );

    [self addChild:tableViewer z:1];

}*/
/*
-(void) isSelectAreaOne:(id)sender
{
    [self removeChild:tableView cleanup:YES];
    _levels = [[NSArray alloc]initWithObjects:@"Level_0",@"Level_1",@"Level_2",@"Level_3",@"Level_99", nil];
    _levelNum = 10;
    tableView = [[CCTableView alloc]init];
    tableView.dataSource = self;
    [self setTableView:tableView];
    
    //cclog test
    int i;
    for (i=0; i<_levels.count; i++) {
        CCLOG(@"%@",_levels[i]);
    }
 
    
    [self.delegate controlSlide:slide];
    slide = slide +1;
}

-(void) isSelectAreaTwo:(id)sender
{
    CCNode * ccp1 = [CCBReader load:@"ccpLittleFire"];
    ccp1.position = ccp(40, 160);
    [self addChild:ccp1];
    
    CCNode * ccp2 = [CCBReader load:@"ccpLittleDust"];
    ccp2.position = ccp(240,20);
    
    [self scheduleBlock:^(CCTimer *timer) {
        [ccp1 removeFromParent];

        [self addChild:ccp2];
    } delay:10];
    [self scheduleBlock:^(CCTimer *timer) {
        [ccp2 removeFromParent];
    } delay:20];
 
    [self removeChild:tableView cleanup:YES];

    _levels = [[NSArray alloc]initWithObjects:@"Level_4",@"Level_5",@"Level_6",@"Level_7", nil];
    _levelNum =20 ;
    tableView = [[CCTableView alloc]init];
    tableView.dataSource = self;
    [self setTableView:tableView];

    
    //cclog test
    int i;
    for (i=0; i<_levels.count; i++) {
            CCLOG(@"%@",_levels[i]);
    }
 
    
}
*/
/*
-(CCTableViewCell *) tableView:(CCTableView *)tableView nodeForRowAtIndex:(NSUInteger)index
{
    
    CCTableViewCell* cell = [CCTableViewCell node];
    cell.userInteractionEnabled = YES;
    cell.contentSizeType = CCSizeTypeMake(CCSizeUnitNormalized, CCSizeUnitUIPoints);
    cell.contentSize = CGSizeMake(1, kSimpleTableViewRowHeight);
    
// Color every other row differently
 
    CCNodeColor* bg;
 
 //   if (index % 2 != 0) bg = [CCNodeColor nodeWithColor:[CCColor colorWithRed:1 green:0 blue:0 alpha:1]];
 //   else
        bg = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.3 green:0.4 blue:0.5 alpha:1]];
 
    
    bg.userInteractionEnabled = YES;
    bg.contentSizeType = CCSizeTypeNormalized;
    bg.contentSize = CGSizeMake(1, 1);
    [cell addChild:bg];
 
// Create a label with the row number
   CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", [self.levels objectAtIndex:index]] fontName:@"HelveticaNeue" fontSize:18 * [CCDirector sharedDirector].UIScaleFactor];
    lbl.positionType = CCPositionTypeNormalized;
    lbl.position = ccp(0.5f, 0.5f);
    
    [cell addChild:lbl];
    

//Create button

    CCButton * bt = [CCButton buttonWithTitle:[NSString stringWithFormat:@"%d",(int) index] fontName:@"微軟正黑體" fontSize:18 ];
    bt.positionType = CCPositionTypeNormalized;
    bt.position = ccp(0.0f,0.0f);
    bt.anchorPoint = ccp(0, 0);
    [self setTableInt:index];
 //   [bt setTarget:self selector:@selector(tableButton:)];
    switch (_tableInt) {
        case 11:
            [bt setTarget:self selector:@selector(tableButton11:)];
            break;
        case 12:
            [bt setTarget:self selector:@selector(tableButton12:)];
            break;
        case 13:
            [bt setTarget:self selector:@selector(tableButton13:)];
            break;
        case 14:
            [bt setTarget:self selector:@selector(tableButton14:)];
            break;
        case 15:
            [bt setTarget:self selector:@selector(tableButton15:)];
            break;
        case 21:
            [bt setTarget:self selector:@selector(tableButton21:)];
            break;
        case 22:
            [bt setTarget:self selector:@selector(tableButton22:)];
            break;
        case 23:
            [bt setTarget:self selector:@selector(tableButton23:)];
            break;
        case 24:
            [bt setTarget:self selector:@selector(tableButton24:)];
            break;
        default:
            break;
    }
    
    
    
    

    [cell addChild:bt];
    
    CCLOG(@"return cell");

    return cell;

}

-(NSUInteger) tableViewNumberOfRows:(CCTableView *)tableView
{
    CCLOG(@"return count: %d",[self.levels count]);
    return [self.levels count];
}

- (float) tableView:(CCTableView*)tableView heightForRowAtIndex:(NSUInteger) index{
    return kCCTestMenuItemHeight;
}
*/

-(void) appearAlertView
{
    CCAlertView *av = [CCAlertView alloc];
    av = (CCAlertView* )[CCBReader load:@"CCAlertView"];
    [av initWithTitle:@"  " message:@"是否進入關卡？" delegate:self cancelButtonTitle:@"否" otherButtonTitle:@"是"];
        [av showAV];

        CCLOG(@"self scheduleblock");

    //BLOCK BUTTONS!
    [self setBlockButton:NO];

}


-(void) isLevel_0First:(id) sender  //  選擇關卡
{
    
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"SwitchLevel"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [self.delegate showLeagueInfo:_isLevel_0First.position :0];

 //   [[OALSimpleAudio sharedInstance] playEffect:@"mapSelectMusic.mp3" loop:NO];


//    [self appearAlertView];


}

-(void) isLevel_1MC:(id) sender
{
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"SwitchLevel"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [self.delegate showLeagueInfo:_isLevel_1MC.position :1];
   //     [[OALSimpleAudio sharedInstance] playEffect:@"mapSelectMusic.mp3" loop:NO];
}


-(void) isSelectLevel_0:(id)sender //level_0 button
{
    [self setBlockButton:NO];
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"SwitchLevel"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self appearAlertView];

    
    CCLOG(@"send level0!");
}

-(void) touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{

    CCLOG(@"touchend");
}

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CCLOG(@"touchBegin");
}
/*
-(void) setTableInt:(int)tableInt
{
    tableInt = tableInt + _levelNum;
    _tableInt = tableInt;
    return ;
}
*/

//set the Ok and Cancel of CCAlertView
- (void) CCAlertView:(CCNode *)alertView indexSelected:(int)index {
    if (index == 0) {
        CCLOG(@"CANCEL Pressed");
        [self setBlockButton:YES];


    }else if (index == 1) {
        CCLOG(@"OK Pressed");
        [self setBlockButton:YES];

            [self.delegate pushLevel];

        
    }
}
-(void) setBlockButton:(BOOL)blockButton
{

 //   _isSelectAreaOne.enabled = blockButton;
 //   _isSelectAreaTwo.enabled = blockButton;
    _isSelectLevel0.enabled = blockButton;
    _isLevel_0First.enabled = blockButton;
    return;
}
/*
-(void) userDefaultO: (id) sender
{
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"Spirit"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void) userDefaultT: (id) sender
{
    [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"Spirit"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void) userDefaultZ:(id) sender
{
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Spirit"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
 */
-(void)onExit {
    [oal stopAllEffects];
    [oal unloadAllEffects];
    [self stopAllActions];
    [self unscheduleAllSelectors];
    [self removeAllChildrenWithCleanup:YES];

    CCLOG(@"Onexit");
    [super onExit];
}
//
// tableButtonset
//
/*
-(void) tableButton:(id)sender
{
    CCLOG(@"table button!!");
}

//
//  11~
//

-(void) tableButton11:(id)sender
{
    CCLOG(@"table button11!!");
}
-(void) tableButton12:(id)sender
{
    CCLOG(@"table button12!!");
}
-(void) tableButton13:(id)sender
{
    CCLOG(@"table button13!!");
}
-(void) tableButton14:(id)sender
{
    CCLOG(@"table button14!!");
}
-(void) tableButton15:(id)sender
{
    CCLOG(@"table button15!!");
}

//
//  21~
//

-(void) tableButton21:(id)sender
{
    CCLOG(@"table button21!!");
}
-(void) tableButton22:(id)sender
{
    CCLOG(@"table button22!!");
}
-(void) tableButton23:(id)sender
{
    CCLOG(@"table button23!!");
}
-(void) tableButton24:(id)sender
{
    CCLOG(@"table button24!!");
}

//  31~
//
*/

//
@end
