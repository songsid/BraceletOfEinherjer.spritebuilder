//
//  Level_0First.m
//  NUTheNord
//
//  Created by Sid on 2014/4/12.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import "Level_0First.h"
#import "LevelScene.h"
#define selfAncherPositionMax  95;
#define selfAncherPositionMin  70;

@implementation Level_0First

-(NSMutableArray *) enemies{
    if (!_enemies) {
        _enemies = [NSMutableArray array];
    }
    return _enemies;
}

-(void) didLoadFromCCB
{
   // [[OALSimpleAudio sharedInstance] playEffect:@"street1.mp3" loop:YES];
    oal = [OALSimpleAudio sharedInstance];

    self.userInteractionEnabled = TRUE;
    
    _physicsNode.collisionDelegate = self; //set collisionDelegate
    mpDistance = 0.0f;
    bRHP = 0;
    dialogOne = NO;
    dialogTwo = NO;
    dialogThree = YES;
    dialogFour = NO;
    dialogTouchOne = NO;
    dialogButtonOne = NO;
    roberShotBo = NO;
    endgame = YES;
    tutorialStep = 0;
    

    _physicsNode.zOrder = 5;
    _beginGnd.physicsBody.collisionType = @"beginGnd";
    switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"Spirit"]) {
        case 0:
            _player = (CCNode *) [CCBReader load:@"PlayerSaber"];
            break;
        case 1:
            _player = (CCNode *) [CCBReader load:@"PlayerLancer"];
            break;
        case 2:
            _player = (CCNode *) [CCBReader load:@"PlayerArcher"];
            break;
            
        default:
            break;
    }
    switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sup"]) {
            
        case 0:
        {
            stJump = ccp(0,750.0f);
            vinaSing = 100;
        }
            break;
        case 1:
        {
            stJump = ccp(0,650.0f);
            vinaSing = 100;
        }
            break;
        case 2:
        {
            stJump = ccp(0,650.0f);
            vinaSing = 150;
        }
            break;
            
            
        default:
            break;
    }

    _player.position = ccp(80, 90);
    [_physicsNode addChild:_player z:1];
    _player.physicsBody.collisionType = @"Player";
  
    [_player.physicsBody applyForce:ccp(8000.0f, 0.0f)];

    _kake = (CCNode *) [CCBReader load:@"Kate"];
    _kake.position = ccp(0,50);
    _kake.scale = 0.8;
    _kake.physicsBody.collisionType = @"Kake";
    [_physicsNode addChild:_kake z:0];
    
    _bRobert = (CCNode *)[CCBReader load:@"enemyRobertBig"];
   // _bRobert.position = ccp(1030, 65);
    _bRobert.position = ccp(5760, 51);
    _bRobert.physicsBody.collisionType = @"enemyRB";
    [_physicsNode addChild:_bRobert];
    [self createEnemyRobert:ccp(1000, 43)];
    [self createEnemyRobert:ccp(2563, 43)];
    ///setting blueGnd
    [self buildBludGnd:ccp(391, 0) :100];
    [self buildBludGnd:ccp(1277, 0) :99];
    [self buildBludGnd:ccp(2219.8f,0) :98];
    [self buildBludGndS:ccp(2971.2f,0) :97];
    [self buildBludGndS:ccp(3300.0f,0) :96];
    [self buildBludGndS:ccp(3570.0f,0) :95];
    [self buildBludGnd:ccp(4636.0f,0) :94];
    [self buildBludGndS:ccp(5400.0f,0) :93];
    [self buildBludGndS:ccp(6200.0f,0) :92];
    ///setting blueTopGnd
    [self buildBlueTopGnd:ccp(446, 95)];
    [self buildBlueTopGnd:ccp(1507, 95)];
    [self buildBlueTopGnd:ccp(1630, 140)];
    [self buildBlueTopGnd:ccp(2042, 95)];
    [self buildBlueTopGnd:ccp(2160, 140)];
    [self buildBlueTopGnd:ccp(3225, 95)];
    [self buildBlueTopGnd:ccp(3755, 95)];
    [self buildBlueTopGnd:ccp(3812, 140)];
    [self buildBlueTopGnd:ccp(3935, 140)];
    [self buildBlueTopGnd:ccp(4051, 95)];
    [self buildBlueTopGnd:ccp(4199, 95)];
    [self buildBlueTopGnd:ccp(4463, 95)];
    [self buildBlueTopGnd:ccp(4582, 95)];
}

-(void) buildBludGnd :(CGPoint)x :(NSInteger) z
{
    _blueGnd = [CCBReader load:@"blueGnd"];
    _blueGnd.anchorPoint = ccp(0, 0);
    _blueGnd.position = x;
    _blueGnd.physicsBody.elasticity = 0;
    _blueGnd.physicsBody.collisionType = @"blueGnd";
    [_physicsNode addChild:_blueGnd z:z];
}
-(void) buildBludGndS :(CGPoint)x :(NSInteger) z
{
    _blueGnd = [CCBReader load:@"blueGndS"];
    _blueGnd.anchorPoint = ccp(0, 0);
    _blueGnd.position = x;
    _blueGnd.physicsBody.elasticity = 0;
    _blueGnd.physicsBody.collisionType = @"blueGnd";
    [_physicsNode addChild:_blueGnd z:z];
}
-(void) buildBlueTopGnd :(CGPoint)x
{
    _blueTopGnd = [CCBReader load:@"blueTopGnd"];
    _blueTopGnd.anchorPoint = ccp(0, 0);
    _blueTopGnd.physicsBody.elasticity = 0;
    _blueTopGnd.position = x;
    _blueTopGnd.physicsBody.collisionType = @"blueGnd";
    [_physicsNode addChild:_blueTopGnd];
}
-(void) createArrowShot //Archer attack
{
    _skillFire = [CCBReader load:@"PlayerArcherArrow"];
    _skillFire.position = ccp(_player.position.x +34, _player.position.y+ 30);
    _skillFire.physicsBody.collisionType = @"slFire";
    _skillFire.physicsBody.affectedByGravity = YES;
    _skillFire.physicsBody.allowsRotation = YES;
    [self scheduleBlock:^(CCTimer *timer) {
        [_physicsNode addChild:_skillFire];
        if (_skillFire.parent) {
            [_skillFire.physicsBody applyImpulse:ccp(440,50)];}
    } delay:0.3f];
    [self scheduleBlock:^(CCTimer *timer) {
        [_skillFire removeFromParentAndCleanup:YES];
    } delay:0.7f];
    
}
-(void) createSkillShot
{
    switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"Spirit"]) {
        case 0:
            _skillFire = [CCBReader load:@"skillSaberShot"];
            _skillFire.position = ccp(_player.position.x +65, _player.position.y +40);
            _skillFire.physicsBody.collisionType = @"skillFire";
            [_physicsNode addChild:_skillFire z:10];
            break;
        case 1:
        {
            _skillFire = [CCBReader load:@"skillLancerShot"];
            _skillFire.position = ccp(_player.position.x +34, _player.position.y+ 30);
            _skillFire.physicsBody.collisionType = @"skillFire";
            [self scheduleBlock:^(CCTimer *timer) {
                [_physicsNode addChild:_skillFire z:10];
                 [_skillFire.physicsBody applyImpulse:ccp(10000, 0)];
            } delay:2.2f];

        }
            break;
        case 2:
        {
            _skillFire = [CCBReader load:@"PlayerArcherArrow"];
            [_skillFire.userObject runAnimationsForSequenceNamed:@"Skill"];
            _skillFire.position = ccp(_player.position.x +65, _player.position.y +40);
            _skillFire.physicsBody.collisionType = @"skillFire";
            _skillFire.physicsBody.affectedByGravity = NO;
            _skillFire.physicsBody.allowsRotation = NO;
            [_physicsNode addChild:_skillFire z:10];
            [self scheduleBlock:^(CCTimer *timer) {
                if (_skillFire.parent) {
                    [_skillFire.physicsBody applyImpulse:ccp(350, 0)];}
            } delay:0.0f];
            [self scheduleBlock:^(CCTimer *timer) {
                [_skillFire removeFromParentAndCleanup:YES];
            } delay:0.7f];
        }
                      break;
            
        default:
            break;
    }

}
-(void) createEnemyRobert :(CGPoint)x
{
    _enemy = [CCBReader load:@"enemy"];
    _enemy.physicsBody.collisionType = @"enemy";
    _enemy.position = x;
    [_physicsNode addChild:_enemy];
    
   
}
///                    create point  speed           delayshotTime
-(void) createRobertShot :(CGPoint)x :(CGPoint)v :(float) delayShot
{
    Level_0First * lv = self; // test self block
    _robertShot = [CCBReader load:@"robertShotStable"];
    _robertShot.anchorPoint = ccp(0.5, 0.5);
    _robertShot.position = x;
    _robertShot.physicsBody.collisionType = @"robertShot";
    [_physicsNode addChild:_robertShot];
    [self scheduleBlock:^(CCTimer *timer) {
        _robertShotPre = [CCBReader load:@"robertShot"];
        _robertShotPre.position = x;
        [lv addChild:_robertShotPre];
        
        [self scheduleBlock:^(CCTimer *timer) {
                [_robertShot.physicsBody applyForce:v];
        } delay:delayShot];
        [self scheduleBlock:^(CCTimer *timer) {
                [_robertShot removeFromParent];
                [_robertShotPre removeFromParent];
        } delay:2.0f];
    } delay:0.8f];
}
-(void) createEnemyMouse :(CGPoint)x :(CGPoint)v :(CGPoint)vJ :(float)jumpTime :(int)mode
{
    switch (mode) {
        case 0:
        {
            _enemy = [CCBReader load:@"enemyMouse"];
            _enemy.physicsBody.collisionType = @"enemy";
            _enemy.position = x;
            [_physicsNode addChild:_enemy];
             [self.enemies addObject:_enemy];
            [_enemy.physicsBody applyForce:v];
            [self scheduleBlock:^(CCTimer *timer) {
                if (_enemy.parent) {
                    [_enemy.physicsBody applyImpulse:vJ];
                }
            } delay:jumpTime];
        }
            break;
            
        case 1:
        {
            _enemy = [CCBReader load:@"enemyMouse"];
            _enemy.physicsBody.collisionType = @"enemy";
            _enemy.position = x;
            [_physicsNode addChild:_enemy];
             [self.enemies addObject:_enemy];
            [_enemy.physicsBody applyForce:v];
            [self scheduleBlock:^(CCTimer *timer) {
                if (_enemy.parent){
                    [_enemy.physicsBody applyImpulse:vJ];}
            } delay:jumpTime/2];
            [self scheduleBlock:^(CCTimer *timer) {
                if (_enemy.parent){
                    [_enemy.physicsBody applyImpulse:vJ];}
            
            } delay:jumpTime];
        }
            
            break;
        default:
            break;
    }



}

-(void) update:(CCTime)delta

{
    CCLOG(@"delta = %f",delta);
    CCLOG(@"player.y = %f playerY.y = %f",_player.position.y,_playerY.y);

    ///////////set jump
/*    if ((( ((_playerY.y - _player.position.y)<10*delta) && (_playerY.y - _player.position.y)>=0.0f)) || (((_playerY.y - _player.position.y)>(-10*delta) && (_playerY.y - _player.position.y)<=0.0f))) {
        //CCLOG(@"Y==Y");
        enableJump = YES;
    }else{
        enableJump = NO;
    }*/
       ///set labBG
    float bg = _player.position.x- _playerY.x;
    _labBG1.position = ccp(_labBG1.position.x - bg*0.25f,_labBG1.position.y );
    _labBG2.position = ccp(_labBG2.position.x - bg*0.25f,_labBG2.position.y );
    _labBG3.position = ccp(_labBG3.position.x - bg*0.25f,_labBG3.position.y );

    /////// player & layer position
    if (!deltaStop) {
        if ((_player.position.x -_playerY.x > 100*delta) && (_player.position.x <selfAncherPosition+160) && (_player.position.x >selfAncherPosition+100)) {
            [_player.physicsBody applyForce:ccp(-5000.0f *delta, 0.0f)];

        }
        if ((_player.position.x -_playerY.x < 100*delta)&& (_player.position.x <selfAncherPosition+160)&& (_player.position.x >selfAncherPosition+100))
        {
            [_player.physicsBody applyForce:ccp(5000.0f *delta, 0.0f)];
        }
        if (_player.position.x>selfAncherPosition+160) {
            float f;
            f = _player.position.x - selfAncherPosition+160;
            if (f>55) {
                f=55;
            }
            f = 1 + f*(-1/55);
            [_player.physicsBody applyForce:ccp(-6000.0f * delta * f, 0.0f)];

        }
        if (_player.position.x<selfAncherPosition+100) {
            float f;
            float f2;
            f = selfAncherPosition +100 - _player.position.x;
            CCLOG(@"f = %f",f);
            if (f>50) {
                f = 70;
            }
            f2 = f*f;
            CCLOG(@"f2 = %f",f2);
            f =  f2/4900;
            if ((_player.position.x-_playerY.x > 120 *delta) && f<1) {
                [_player.physicsBody applyForce:ccp(-5000.0f *delta, 0.0f)];
                CCLOG(@"+70 --ing");
            }else  {
                [_player.physicsBody applyForce:ccp(8000.0f *delta * f, 0.0f)];
            }

            CCLOG(@"Force = %f \n f=%f",6000*delta*f,f);
        }
    }else if (deltaStop){
        _player.position = ccp(skillPosition.x,_player.position.y);
        
        
        for (CCNode *mouse in self.enemies) {
            if (mouse.position.x - selfAncherPosition > 0 &&  mouse.position.x -selfAncherPosition < 800) {
                CCLOG(@"Target mouse found!");
                CCLOG(@"mouse.position = %f",mouse.position.x);
                mouse.physicsBody.density = 100;
                mouse.physicsBody.friction = 100;
              //  mouse.paused = YES;
            }
        }
//        self.enemies
        
    }
    for (CCNode * m in self.enemies) {
        if (m.position.x-selfAncherPosition > 0 && m.position.x - selfAncherPosition < 800) {
            if (m.parent) {
                mouseExisted = YES;
            }else {
                mouseExisted = NO;
            }
        }
    }
    ///////

    switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"Spirit"]) {
        case 0:
         
            break;
        case 1:
           
            break;
        case 2:
            if (_skillFire.position.x - _player.position.x >230 && ![[_skillFire.userObject runningSequenceName]isEqualToString:@"Skill"]) {
                if (_skillFire.parent) {
                [_skillFire removeFromParentAndCleanup:YES];
                }
            }
            break;
            
        default:
            break;
    }
 ///set Tutorial
    
    if (_player.position.x > 0) {
        if (!dialogOne) {

        self.userInteractionEnabled = NO;

            [oal stopAllEffects];
                [oal playEffect:@"d4.caf" volume:0.5 pitch:1.0f pan:0.0f loop:YES];
                
            
        [self.delegate touchToPaused:dialogOne];
        CCLOG(@"touchToJump");
            dialogOne = YES;
            tutorialStep = tutorialStep+1;
        }
    }
    
    if (_player.position.x >320){
    
        if (!dialogTwo) {

        [[NSUserDefaults standardUserDefaults]setInteger:10 forKey:@"DialogInt"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            Level_0First * lv = self; // test self block
        [self.delegate touchToPaused:dialogTwo];
            dialogTwo = YES;
            [self scheduleBlock:^(CCTimer *timer) {
                dialogTouchOne = YES;
                lv.userInteractionEnabled = YES;
            } delay:0.5f]; //set delay for touch remove dialog
            tutorialStep = tutorialStep+1;

        }
    
    }
    
    /// robert shot!!

    if (_player.position.x > 500) {
        if (!roberShotBo) {
            roberShotBo = YES;
            [self createRobertShot:ccp(970, 65) :ccp(-20000, 0) :1.0f];
          
            tutorialStep = tutorialStep+1;
        }
    }
    
    /// jump over robertshot
    if (_player.position.x > 730) {
        if (!dialogFour) {
            
            [[NSUserDefaults standardUserDefaults]setInteger:12 forKey:@"DialogInt"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            self.userInteractionEnabled = NO;
            [self.delegate touchToPaused:dialogTwo];;
            dialogFour = YES;
            Level_0First * lv = self; // test self block
            [self scheduleBlock:^(CCTimer *timer) {
                dialogTouchOne = YES;
                lv.userInteractionEnabled = YES;
            } delay:0.5f]; //set delay for touch remove dialog
            tutorialStep = tutorialStep+1;

        }
    }
    if ([[NSUserDefaults standardUserDefaults]integerForKey:@"Spirit"] !=2) {
        
        if (_player.position.x >970){
        
            if (dialogThree) {
                //remove robertshot!
                [[NSUserDefaults standardUserDefaults]setInteger:14 forKey:@"DialogInt"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                self.userInteractionEnabled = NO;
                [self.delegate touchToPaused:dialogThree];
                dialogThree = NO;
                [self scheduleBlock:^(CCTimer *timer) {
                    dialogButtonOne = YES;
               
                } delay:0.0f]; //set delay for touch remove dialog
                tutorialStep = tutorialStep+1;
            }
        
        }
    }else
        if (_player.position.x >850){
        
        if (dialogThree) {
            //remove robertshot!
            [[NSUserDefaults standardUserDefaults]setInteger:14 forKey:@"DialogInt"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            self.userInteractionEnabled = NO;
            [self.delegate touchToPaused:dialogThree];
            dialogThree = NO;
            [self scheduleBlock:^(CCTimer *timer) {
                dialogButtonOne = YES;
                
            } delay:0.0f]; //set delay for touch remove dialog
            tutorialStep = tutorialStep+1;
        }
        
    }
    if (_player.position.x > 2080 && tutorialStep ==5) {
        [self createRobertShot:ccp(2555, 65) :ccp(-30000, 0) :0.63f];
        
        tutorialStep = tutorialStep+1;

    }
    
    if (_player.position.x > 2480 && tutorialStep ==6) {
        [self createEnemyMouse:ccp(3100, 65) :ccp(-5000, 0) :ccp(-100, 600) :3.0f :0];
        tutorialStep = tutorialStep +1;
    }
    
    if (_player.position.x > 2730 && tutorialStep ==7) {
        tutorialStep = tutorialStep +1;
        if (mouseExisted) {
        [[NSUserDefaults standardUserDefaults]setInteger:16 forKey:@"DialogInt"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.delegate touchToPaused:NO];
        }
    }
    
    if (_player.position.x > 3050 && tutorialStep ==8) {
        [self createEnemyMouse:ccp(3500, 65) :ccp(-5000, 0) :ccp(-100, 600) :2.0f :0];
        tutorialStep = tutorialStep +1;
    }
    
    if (_player.position.x > 3200 && tutorialStep ==9) {
        [self createEnemyRobert:ccp(3693, 43)];
        [self createRobertShot:ccp(3663,65) :ccp(-20000, 0) :1.4f];
        tutorialStep = tutorialStep +1;
    }
    if (_player.position.x > 4613 && tutorialStep ==10) {
        [self createEnemyMouse:ccp(5100, 65) :ccp(-5000, 0) :ccp(-50, 600) :2.0f :1];
        tutorialStep = tutorialStep +1;
    }
    
    if (_player.position.x >5200 && tutorialStep ==11) {

        tutorialStep = tutorialStep +1;

    }
    ///// set MPincrease!!!
    
    mpDistance  = mpDistance + vinaSing * delta;
    if (mpDistance>=150) {
        [self.delegate transMpIncrease:1];
        mpDistance = 0.0f;
    }
    /// hpmpInfo opacity
    if (_player.position.y > 200) {
        [self.delegate hpmpInfoOpacity:YES];
    }else [self.delegate hpmpInfoOpacity:NO];
    

    ///EndGame/////////////////////////////////////////////////////////////
    if((_player.position.y<0))
    {
        [_player removeFromParent];
        [self.delegate appearFailCount];
        CCLOG(@"gameover!!!");
    }
    ///HP=0 Endgame
    if ([self.delegate getHp]<=0) {
        [_player removeFromParent];
        [self.delegate appearFailCount];;
    }
    
    ///player<self endgame
    if(_player.position.x < selfAncherPosition-40 )
    {
        [_player removeFromParent];
        [self.delegate appearFailCount];
    }
    
    
    ///completegame
    if ((_player.position.x > 5400 && !endgame )) {
        endgame = YES;
        deltaStop = YES;
        skillPosition.x = _player.position.x;
        [self.delegate showClearCount];
        [self.delegate buttonControl:NO];
        [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"DialogInt"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
    
    
    ////////////player & layer position
    
    if (![self.delegate getPaused] && !deltaStop) {
        if ((_player.position.x-_playerY.x)<1) {
            [_player.physicsBody applyForce:ccp(6500.0f *delta, 0.0f)];
            self.position = ccp(self.position.x - 50*delta, self.position.y);
            selfAncherPosition = selfAncherPosition +50*delta;
            CCLOG(@"11111");
        }else{
            self.position = ccp(self.position.x - 100*delta, self.position.y);
            selfAncherPosition = selfAncherPosition + 100*delta;
            CCLOG(@"2");
        }
    }
    if (deltaStop) {
        self.position = ccp(self.position.x, self.position.y);
    }
    if(_sFire)
    {
        _sFire.position = ccp(_player.position.x+25,1000);
    }
    CCLOG(@"_sFire.position = %f,%f",_sFire.position.x,_sFire.position.y);
    _playerY = ccp(_player.position.x, _player.position.y);
 
    CCLOG(@"_player.position.x = %f\n _playerY.position.x = %f",_player.position.x,_playerY.x);
    CCLOG(@"ancherpoint = %f",selfAncherPosition);
    ///////////
    ///set kake
        //set position
    if (((_player.position.y - _playerY.y >=0)&&(_player.position.y - _playerY.y <0.1)) && enableJump) {
        
            _kake.position = ccp(_playerY.x, _playerY.y-0.1f);
        
        
        }else{_kake.position = ccp(_player.position.x,_kake.position.y);}
    
        //set scale
    if (_player.position.y>=_kake.position.y) {
                if ( _player.position.y - _kake.position.y <180) {
                    _kake.scale =  (1-((_player.position.y +38 - _kake.position.y)/135))*1;
                }else {
            _kake.scale = 0;
        }
    }else{
        _kake.scale = 0;
    }
    
   // [_kake.physicsBody applyForce:ccp(0, -90*delta)];
    CCLOG(@"_kate.force = %f,%f",_kake.physicsBody.force.x,_kake.physicsBody.force.y);
    CCLOG(@"_kate.pox = %f,%f",_kake.position.x,_kake.position.y);
    CCLOG(@"up playerY = %f",_playerY.x);

}



-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    int dia = [[NSUserDefaults standardUserDefaults]integerForKey:@"DialogInt"];
    CCLOG(@"dialog int = %d",dia);
    CCLOG(@"levelscenepause = %hhd",[self.delegate getPaused]);
    if ([self.delegate getPaused]&& (dia>=10)&& dialogTouchOne) {
        [self.delegate removeDialog];
        self.userInteractionEnabled =YES;
        dialogTouchOne = NO;
        CCLOG(@"removedia");
    }
    
    if (enableJump && !deltaStop)
    {
        [_player.physicsBody applyImpulse:stJump];
        if (![[_player.userObject runningSequenceName]isEqualToString:@"Attack"]) {
        [_player.userObject runAnimationsForSequenceNamed:@"Jump"];
        }
    }
    return ;
}

-(void)attack
{
    if (![[_player.userObject runningSequenceName]isEqualToString:@"Attack"]) {
        
        ///step 4 robert remove
    int dia = [[NSUserDefaults standardUserDefaults]integerForKey:@"DialogInt"];
    if ([self.delegate getPaused]&& (dia>=12)&& dialogButtonOne) {
        [self.delegate removeDialog];
        dialogButtonOne = NO;
        self.userInteractionEnabled = YES;
        CCLOG(@"removedia");
        }

        switch ([[NSUserDefaults standardUserDefaults]integerForKey:@"Spirit"]) {
            case 0:
            {
            if ([self.delegate getMp]>=3) {
                [_player.userObject runAnimationsForSequenceNamed:@"Attack"];
                CCLOG(@"%@",[_player.userObject runningSequenceName]);
                [self.delegate transMpDecrease:3];
                // shot an attack at px40 py and at the update move to px 25 py1000
                _sFire = [CCBReader load:@"attack"];
                _sFire.position = ccp(_player.position.x + 50, _player.position.y);
                _sFire.physicsBody.collisionType = @"slFire";
                [_physicsNode addChild:_sFire];
                
                [self scheduleBlock:^(CCTimer *timer) {
                    [_sFire removeFromParent];
                } delay:0.2f];
                CCLOG(@"slamfire = %@,position = %f,%f",_sFire,_sFire.position.x,_sFire.position.y);
                CCLOG(@"slfire = %@",_sFire.physicsBody.collisionType);
                /* CCNode * sand = [CCBReader load:@"Sand"];
                 sand.position = ccp(_player.position.x-20,_player.position.y);
                 [self addChild:sand];*/
                [oal playEffect:@"sabersMusic.mp3"];
            }
                break;
            }
            case 1:
            {
                [_player.userObject runAnimationsForSequenceNamed:@"Attack"];
                CCLOG(@"%@",[_player.userObject runningSequenceName]);
                [self.delegate transMpDecrease:3];
                // shot an attack at px40 py and at the update move to px 25 py1000
                _sFire = [CCBReader load:@"attack"];
                _sFire.position = ccp(_player.position.x + 50, _player.position.y);
                _sFire.physicsBody.collisionType = @"slFire";
                [_physicsNode addChild:_sFire];
                
                [self scheduleBlock:^(CCTimer *timer) {
                    [_sFire removeFromParent];
                } delay:0.2f];
                CCLOG(@"slamfire = %@,position = %f,%f",_sFire,_sFire.position.x,_sFire.position.y);
                CCLOG(@"slfire = %@",_sFire.physicsBody.collisionType);
                /* CCNode * sand = [CCBReader load:@"Sand"];
                 sand.position = ccp(_player.position.x-20,_player.position.y);
                 [self addChild:sand];*/
                [oal playEffect:@"lancerSMusic.caf" volume:1 pitch:1.0f pan:0.0f loop:NO];
                break;
            }
            case 2:
            {
                if ([self.delegate getMp]>2 && !_skillFire.parent) {
                [_player.userObject runAnimationsForSequenceNamed:@"Attack"];
                CCLOG(@"%@",[_player.userObject runningSequenceName]);
                [self.delegate transMpDecrease:2];
                [self createArrowShot];
                    [oal playEffect:@"archerShotMusic"                    volume:1.5 pitch:1.0f pan:0.0f loop:NO];
                }
                break;
            }
            default:
                break;
        }

    }
}

-(void) skill
{
    switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"Spirit"]) {
    case 0:
        {
            if ((![[_player.userObject runningSequenceName]isEqualToString:@"Attack"] && enableJump) && [self.delegate getMp]>=9) {
                deltaStop = YES;
                _skillBG.position = ccp(selfAncherPosition, 0); //load From ccb skillBG
                _skillBG.visible = YES;
                
                skillPosition = ccp(_player.position.x, _player.position.y);
                [self.delegate transMpDecrease:9];
                [_player.physicsBody applyImpulse:ccp(0, 700)];
                [_player.userObject runAnimationsForSequenceNamed:@"Skill"];
                Level_0First * lv = self; // test self block
                [self scheduleBlock:^(CCTimer *timer) {
                    [lv.delegate scrollViewShake];
                    CCNode * skillBombccp = [CCBReader load:@"skillCCPSaberTwo"];
                    skillBombccp.position = ccp(_player.position.x +140, _player.position.y);
                    [lv addChild:skillBombccp];
                    
                    CCNode * skillBombccpo = [CCBReader load:@"skillCCPSaberTwo"];
                    skillBombccpo.position = ccp(_player.position.x +220, _player.position.y);
                    [lv addChild:skillBombccpo];
                    
                    CCNode * skillBombccpa = [CCBReader load:@"skillCCPSaberTwo"];
                    skillBombccpa.position = ccp(_player.position.x +300, _player.position.y);
                    [lv addChild:skillBombccpa];
                    
                    [lv createSkillShot];
                    
                    [lv scheduleBlock:^(CCTimer *timer) {
                        [_skillFire.physicsBody applyImpulse:ccp(10000, 0)];
                    } delay:0.3];
                } delay:1.0f ];
                [self scheduleBlock:^(CCTimer *timer) {
                    deltaStop = NO;
                    [oal playEffect:@"exp.caf" volume:5 pitch:1.0f pan:0.0f loop:NO];
                    [lv scheduleBlock:^(CCTimer *timer) {
                        _skillBG.visible = NO;
                    } delay:0.8];
                    
                } delay:1.5];
            }
        }
        break;
    case 1:
        {
            if ((![[_player.userObject runningSequenceName]isEqualToString:@"Attack"] && enableJump) && [self.delegate getMp]>=9) {
                deltaStop = YES;
                _skillBG.position = ccp(selfAncherPosition, 0); //load From ccb skillBG
                _skillBG.visible = YES;
                
                skillPosition = ccp(_player.position.x, _player.position.y);
                [self.delegate transMpDecrease:9];
                [_player.physicsBody applyImpulse:ccp(0, 700)];
                [_player.userObject runAnimationsForSequenceNamed:@"Skill"];
                Level_0First * lv = self;
                [self scheduleBlock:^(CCTimer *timer) {
                    [oal playEffect:@"lancerSkMusic.caf"];

                    [lv createSkillShot];
                    
                    [lv scheduleBlock:^(CCTimer *timer) {
                        [oal playEffect:@"exp.caf" volume:5 pitch:1.0f pan:0.0f loop:NO];
                        [lv.delegate scrollViewShake];
                      
                    } delay:1.0f];
                } delay:1.0f ];
                [self scheduleBlock:^(CCTimer *timer) {
                    deltaStop = NO;
                    [lv scheduleBlock:^(CCTimer *timer) {
                        _skillBG.visible = NO;
                    } delay:0.2f];
                    
                } delay:4.3f];
            }
        }
        break;
    case 2:
        {
            if ((![[_player.userObject runningSequenceName]isEqualToString:@"Attack"] && enableJump) && [self.delegate getMp]>=9) {
                deltaStop = YES;
                _skillBG.position = ccp(selfAncherPosition, 0); //load From ccb skillBG
                _skillBG.visible = YES;
                
                skillPosition = ccp(_player.position.x, _player.position.y);
                [self.delegate transMpDecrease:9];
                //[_player.physicsBody applyImpulse:ccp(0, 700)];
                [_player.userObject runAnimationsForSequenceNamed:@"Skill"];
                Level_0First * lv = self;
                [self scheduleBlock:^(CCTimer *timer) {
                 /*   [self.delegate scrollViewShake];
                    CCNode * skillBombccp = [CCBReader load:@"skillCCPSaberTwo"];
                    skillBombccp.position = ccp(_player.position.x +140, _player.position.y);
                    [self addChild:skillBombccp];
                    
                    CCNode * skillBombccpo = [CCBReader load:@"skillCCPSaberTwo"];
                    skillBombccpo.position = ccp(_player.position.x +220, _player.position.y);
                    [self addChild:skillBombccpo];
                    
                    CCNode * skillBombccpa = [CCBReader load:@"skillCCPSaberTwo"];
                    skillBombccpa.position = ccp(_player.position.x +300, _player.position.y);
                    [self addChild:skillBombccpa];
                   */
                    [oal playEffect:@"archerSKM.caf"];
                    [lv createSkillShot];
                    
                } delay:1.0f ];
                [self scheduleBlock:^(CCTimer *timer) {
                    deltaStop = NO;
                    [lv scheduleBlock:^(CCTimer *timer) {
                        _skillBG.visible = NO;
                    } delay:0.8];
                    
                } delay:1.5];
            }
        }
        break;
    }
}

-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair skillFire:(CCNode *)nodeA enemy:(CCNode *)nodeB
{
    
    [nodeB removeFromParent];
    return YES;
}

-(BOOL) ccPhysicsCollisionPreSolve:(CCPhysicsCollisionPair *)pair skillFire:(CCNode *)nodeA enemy:(CCNode *)nodeB
{
    [pair ignore];
    CCLOG(@"cc2");
    return NO;
}
-(BOOL) ccPhysicsCollisionPreSolve:(CCPhysicsCollisionPair *)pair skillFire:(CCNode *)nodeA Player:(CCNode *)nodeB
{
    CCLOG(@"cc3");
    return    [pair ignore];
}
-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair Player:(CCNode *)nodeA enemyRB:(CCNode *)nodeB
{
    CCLOG(@"cc4");
    [self.delegate transHpDecrease:3];
    [_player.physicsBody applyImpulse:ccp(-300, 500)];
    return YES;
}
-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair slFire:(CCNode *)nodeA enemyRB:(CCNode *)nodeB
{
    CCLOG(@"cc5");
     bRHP = bRHP +1;
    return YES;
}
-(void) ccPhysicsCollisionSeparate:(CCPhysicsCollisionPair *)pair slFire:(CCNode *)nodeA enemyRB:(CCNode *)nodeB
{
    if (bRHP < 3) {
        if (_bRobert.parent) {
            [_bRobert.physicsBody applyImpulse:ccp(1000,400)];}
    }
        if (bRHP ==3) {
             [nodeB removeFromParent];
            [self scheduleBlock:^(CCTimer *timer) {
                endgame = NO;
            } delay:3];
        }
}
-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair skillFire:(CCNode *)nodeA enemyRB:(CCNode *)nodeB
{
    CCLOG(@"cc6");
    [nodeB removeFromParent];
    [self scheduleBlock:^(CCTimer *timer) {
        endgame = NO;
    } delay:3];
    return YES;
}
-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair Player:(CCNode *)nodeA enemy:(CCNode *)nodeB
{
   /* NSString * str = [_player.userObject runningSequenceName];
      if ([str isEqualToString:@"Attack"]) {
         
          CGPoint  point = ccp(nodeB.position.x,nodeB.position.y);
          [nodeB removeFromParentAndCleanup:YES];
          CCNode * exp = [CCBReader load:@"EnemyKill"];
          exp.position = point;
          [self addChild:exp];
          

        CCLOG(@"attack!!!!!!!!!!!!!!");
          return YES;   }else */
        [self.delegate transHpDecrease:1];
        [_player.physicsBody applyImpulse:ccp(-300,430.0f)];
        CCLOG(@"damage!!!");
        return NO;
    
    CCLOG(@"collision P E!!");
    
}
-(BOOL) ccPhysicsCollisionPreSolve:(CCPhysicsCollisionPair *)pair Player:(CCNode *)nodeA enemy:(CCNode *)nodeB
{
    if ([[_player.userObject runningSequenceName]isEqualToString:@"Attack"]) {
        CGPoint  point = ccp(nodeB.position.x,nodeB.position.y);
        [nodeB removeFromParentAndCleanup:YES];
        CCNode * exp = [CCBReader load:@"EnemyKill"];
        exp.position = point;
        [self addChild:exp];
    }
    return YES;
}
-(void) ccPhysicsCollisionSeparate:(CCPhysicsCollisionPair *)pair Player:(CCNode *)nodeA enemy:(CCNode *)nodeB
{
    CCLOG(@"collision separata!!!!");
}


-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair Sword:(CCNode *)nodeA Player:(CCNode *)nodeB
{
    CCLOG(@"collision sword!!!");
    return  YES;
}

-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair Player:(CCNode *)nodeA robertShot:(CCNode *)nodeB
{
    CCNode * beshot = [CCBReader load:@"beshot"];
    beshot.position = ccp(_player.position.x+4, _player.position.y+70);
    [self addChild:beshot];
    [_player.physicsBody applyImpulse:ccp(-150,500.0f)];
        [self.delegate transHpDecrease:4];
        CCLOG(@"damage!!!");

    return YES;
}

-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair Player:(CCNode *)nodeA blueGnd:(CCNode *)nodeB
{
    enableJump = YES;
    CCLOG(@"Player on thee _blueGnd!!!!!");
    return YES;
}
-(BOOL) ccPhysicsCollisionPreSolve:(CCPhysicsCollisionPair *)pair Player:(CCNode *)nodeA blueGnd:(CCNode *)nodeB
{
    enableJump = YES;
    CCLOG(@"Player on thee _blueGnd!!!!!");
    return YES;
}
-(BOOL) ccPhysicsCollisionPreSolve:(CCPhysicsCollisionPair *)pair Player:(CCNode *)nodeA beginGnd:(CCNode *)nodeB
{
    enableJump = YES;
    CCLOG(@"Player on thee _bGnd!!!!!");
    return YES;
}
-(void)ccPhysicsCollisionSeparate:(CCPhysicsCollisionPair *)pair Player:(CCNode *)nodeA blueGnd:(CCNode *)nodeB
{
    enableJump = NO;

}
-(void)ccPhysicsCollisionSeparate:(CCPhysicsCollisionPair *)pair Player:(CCNode *)nodeA beginGnd:(CCNode *)nodeB
{
    enableJump = NO;
    
}

-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair slFire:(CCNode *)nodeA enemy:(CCNode *)nodeB
{
    CCLOG(@"slamFire!!");
    CGPoint oldnb = ccp(nodeB.position.x, nodeB.position.y);
    [nodeB removeFromParent];
    [nodeA removeFromParentAndCleanup:YES];
    CCNode * sf = [CCBReader load:@"slamFire"];
    sf.position = ccp(oldnb.x, oldnb.y);
    [self addChild:sf];
    return YES;
}
-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair Player:(CCNode *)nodeA Kake:(CCNode *)nodeB
{
    CCLOG(@"ig begin");
    return [pair ignore];
}

-(BOOL) ccPhysicsCollisionPreSolve:(CCPhysicsCollisionPair *)pair Player:(CCNode *)nodeA Kake:(CCNode *)nodeB
{
    CCLOG(@"player & kake ignore!");
    return [pair ignore];
}

-(void)onExit {
    [oal stopAllEffects];
    [oal unloadAllEffects];
    [self stopAllActions];
    [_enemies removeAllObjects];
    [self unscheduleAllSelectors];
    
    [self removeAllChildrenWithCleanup:YES];
    
    CCLOG(@"Onexit");
    [super onExit];
}
@end


