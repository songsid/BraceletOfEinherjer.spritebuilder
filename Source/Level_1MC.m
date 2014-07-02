//
//  Level_1MC.m
//  NUTheNord
//
//  Created by Sid on 2014/5/6.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import "Level_1MC.h"
#import "LevelScene.h"

@implementation Level_1MC

-(NSMutableArray *) arrayEnemyBat
{
    if (!_arrayEnemyBat) {
        _arrayEnemyBat = [NSMutableArray array];
    }
    return _arrayEnemyBat;
}
-(NSMutableArray *) arrayGnd
{
    if (!_arrayGnd) {
        _arrayGnd = [NSMutableArray array];
    }
    return _arrayGnd;
}
-(NSMutableArray *) arrayEnemyPig
{
    if (!_arrayEnemyPig) {
        _arrayEnemyPig = [NSMutableArray array];
    }
    return  _arrayEnemyPig;
}
-(void) didLoadFromCCB
{
    self.userInteractionEnabled = TRUE;
    oal = [OALSimpleAudio sharedInstance];
    [oal stopAllEffects];
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
    endgame = NO;
    tutorialStep = 0;
    enemyAttackStep = 0;
    setLayer = 0;
    _mcBGFront.zOrder = 200;
    _mcBGFrontUp.zOrder = 200;
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
    
    [self createStone:ccp(1542, 51)];
    [self createStone:ccp(2959, 232)];
    [self createStone:ccp(3186, 106)];
    [self createStone:ccp(4761, 60)];
    ///setting blueGnd
    [self buildBludGnd:ccp(0, 0) :101];
    [self buildBludGnd:ccp(350, 0) :100];
    [self buildBludGnd:ccp(1274, 0) :99];
    [self buildBludGnd:ccp(1874,0) :98];
    [self buildBludGnd:ccp(2913.0f,55) :96];
    [self buildBludGnd:ccp(3314.0f,-25) :95];
    [self buildBludFHGnd:ccp(4506, 12) :95];
    [self buildBludGnd:ccp(4986, 0) :100];

    
    [self buildBlueTopGnd:ccp(298, 99)];
    [self buildBlueTopGnd:ccp(358, 147)];
    [self buildBlueTopGnd:ccp(524, 147)];
    [self buildBlueTopGnd:ccp(690, 147)];
    [self buildBlueTopGnd:ccp(847, 147)];
    [self buildBlueTopGnd:ccp(977, 213)];
    [self buildBlueTopGnd:ccp(1134, 213)];
    [self buildBlueTopGnd:ccp(1906, 99)];
    [self buildBlueTopGnd:ccp(1963, 147)];
    [self buildBlueTopGnd:ccp(2025, 194)];
    
    [self buildBlueTopBGndThree:ccp(2169, 231)]; //set three times long gnd
    
    [self buildBlueTopBGndThree:ccp(2446, 187)];
 
    [self buildBlueTopBGndThree:ccp(2757, 232)];

    
    [self buildBlueTopGnd:ccp(2528, 51)];
    [self buildBlueTopGnd:ccp(2659, 51)];
    [self buildBlueTopGnd:ccp(2777, 51)];
    [self buildBlueTopGnd:ccp(3946, 24)];
    [self buildBlueTopGnd:ccp(4054, 24)];
    [self buildBlueTopGnd:ccp(4169, 30)];
    [self buildBlueTopGnd:ccp(4273, 41)];
    [self buildBlueTopGnd:ccp(4389, 52)];
    
    [self buildBlueTopBGnd:ccp(3581, 187)];
    [self buildBlueTopBGnd:ccp(3667, 187)];
    [self buildBlueTopBGnd:ccp(3803, 227)];
    [self buildBlueTopBGnd:ccp(3963, 229)];
    [self buildBlueTopBGnd:ccp(4131, 223)];
    [self buildBlueTopBGnd:ccp(4292, 232)];
    [self buildBlueTopBGnd:ccp(4447, 242)];
    [self buildBlueTopBGnd:ccp(4605, 242)];
    [self buildBlueTopBGnd:ccp(4765, 241)];

    



}
-(void) buildBludGnd :(CGPoint)x :(NSInteger) z
{
    _blueGnd = [CCBReader load:@"MCGnd"];
    _blueGnd.anchorPoint = ccp(0, 0);
    _blueGnd.position = x;
    _blueGnd.physicsBody.elasticity = 0;
    _blueGnd.physicsBody.collisionType = @"blueGnd";
    [_physicsNode addChild:_blueGnd z:z];
    CCLOG(@"BBG");
}
-(void) buildBludFHGnd :(CGPoint)x :(NSInteger) z
{
    _blueGnd = [CCBReader load:@"MCGndFH"];
    _blueGnd.anchorPoint = ccp(0, 0);
    _blueGnd.position = x;
    _blueGnd.physicsBody.elasticity = 0;
    _blueGnd.physicsBody.collisionType = @"blueGnd";
    [_physicsNode addChild:_blueGnd z:z];
        CCLOG(@"BBFHG");
}
-(void) buildBludGndS :(CGPoint)x :(NSInteger) z
{
    _blueGnd = [CCBReader load:@"blueGndS"];
    _blueGnd.anchorPoint = ccp(0, 0);
    _blueGnd.position = x;
    _blueGnd.physicsBody.elasticity = 0;
    _blueGnd.physicsBody.collisionType = @"blueGnd";
    [_physicsNode addChild:_blueGnd z:z];
        CCLOG(@"BBGs");
}
-(void) buildBlueTopGnd :(CGPoint)x
{
    _blueTopGnd = [CCBReader load:@"MCTopGnd"];
    _blueTopGnd.physicsBody.elasticity = 0;
    _blueTopGnd.position = x;
    _blueTopGnd.physicsBody.collisionType = @"blueGnd";
    [_physicsNode addChild:_blueTopGnd];
        CCLOG(@"BBTG");
}
-(void) buildBlueTopBGnd :(CGPoint)x
{
    _blueTopGnd = [CCBReader load:@"MCTopBridge"];
    _blueTopGnd.physicsBody.elasticity = 0;
    _blueTopGnd.position = x;
    _blueTopGnd.physicsBody.collisionType = @"blueGnd";
    [_physicsNode addChild:_blueTopGnd];
            CCLOG(@"BBTBG");
}
-(void) buildBlueTopBGndThree :(CGPoint)x
{
    _blueTopGnd = [CCBReader load:@"MCTopBridge3"];
    _blueTopGnd.physicsBody.elasticity = 0;
    _blueTopGnd.position = x;
    _blueTopGnd.physicsBody.collisionType = @"blueGnd";
    [_physicsNode addChild:_blueTopGnd];
    CCLOG(@"BBTBG");
}
-(void) createStone :(CGPoint) x
{
    _enemy = [CCBReader load:@"MCEnemyStone"];
    _enemy.position = x;
    _enemy.physicsBody.collisionType = @"Stone";
    [_physicsNode addChild:_enemy];
        CCLOG(@"CS");
}
-(void) createBat :(CGPoint) x
{
    _enemy = [CCBReader load:@"enemyBat"];
    _enemy.position = x;
    _enemy.physicsBody.collisionType = @"enemy";
    _enemy.scale = 0.5f;
    [_physicsNode addChild:_enemy];
    [self.arrayEnemyBat addObject:_enemy];
        CCLOG(@"CB");
    
}
-(void) createPig :(CGPoint) x
{
    _enemy = [CCBReader load:@"enemyPig"];
    _enemy.position = x;
    _enemy.physicsBody.collisionType = @"enemy";
    [_physicsNode addChild:_enemy];
    [_enemy.physicsBody applyImpulse:ccp(-400, 0)];
    [self.arrayEnemyPig addObject:_enemy];
        CCLOG(@"CP");
}
-(void) createArrowShot //Archer attack
{
    _skillFire = [CCBReader load:@"PlayerArcherArrow"];
    _skillFire.position = ccp(_player.position.x +34, _player.position.y+ 30);
    _skillFire.physicsBody.collisionType = @"slFire";
    _skillFire.physicsBody.affectedByGravity = YES;
    
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

-(void) update:(CCTime)delta
{
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
    ///setLayer
    
    if (setLayer == 0 && selfAnchorPosition >0) { //1k
        _layer1k = [CCBReader load:@"Level_1MC_1"];
        _layer1k.anchorPoint = ccp(0, 0);
        _layer1k.position = ccp(1000, 0);
        [self addChild:_layer1k z:-1];
        setLayer = 1;
       [oal playEffect:@"MCMusic.caf" volume:0.5f pitch:1.0 pan:0.0 loop:YES];
    }
    if (setLayer == 1 && selfAnchorPosition >1000) { //2k
        _layer2k = [CCBReader load:@"Level_1MC_2"];
        _layer2k.anchorPoint = ccp(0, 0);
        _layer2k.position = ccp(2000, 0);
        [self addChild:_layer2k z:-1];
        setLayer = 2;
    }
    if (setLayer == 2 && selfAnchorPosition >2000) { //3k
        _layer3k= [CCBReader load:@"Level_1MC_3"];
        _layer3k.anchorPoint = ccp(0, 0);
        _layer3k.position = ccp(3000, 0);
        [self addChild:_layer3k z:-1];
        [_layer1k removeFromParentAndCleanup:YES]; //remove 1k
        setLayer = 3;
    }
    if (setLayer == 3 && selfAnchorPosition >3000) { //4k
        _layer4k = [CCBReader load:@"Level_1MC_4"];
        _layer4k.anchorPoint = ccp(0, 0);
        _layer4k.position = ccp(4000, 0);
        [self addChild:_layer4k z:-1];
        [_layer2k removeFromParentAndCleanup:YES]; //remove 2k
        setLayer = 4;
    }
    if (setLayer == 4 && selfAnchorPosition >4000) { //5k
        _layer5k = [CCBReader load:@"Level_1MC_5"];
        _layer5k.anchorPoint = ccp(0, 0);
        _layer5k.position = ccp(5000, 0);
        [self addChild:_layer5k z:-1];
        [_layer3k removeFromParentAndCleanup:YES]; // remove 3k
        setLayer = 5;
    }
    if (setLayer == 5 && selfAnchorPosition >5000) {
        [_layer4k removeFromParentAndCleanup:YES];
              setLayer = 6;
    }
    
    /////// player & layer position
    if (!deltaStop) {

        if ((_player.position.x -_playerY.x > 100*delta) && (_player.position.x <selfAnchorPosition+230) && (_player.position.x >selfAnchorPosition+160)) {
            [_player.physicsBody applyForce:ccp(-5000.0f *delta, 0.0f)];
            
        }
        if ((_player.position.x -_playerY.x < 100*delta)&& (_player.position.x <selfAnchorPosition+230)&& (_player.position.x >selfAnchorPosition+160))
        {
            [_player.physicsBody applyForce:ccp(5000.0f *delta, 0.0f)];
        }
        if (_player.position.x>selfAnchorPosition+230) {
            float f;
            f = _player.position.x - selfAnchorPosition+230;
            if (f>55) {
                f=55;
            }
            f = 1 + f*(-1/55);
            [_player.physicsBody applyForce:ccp(-6000.0f * delta * f, 0.0f)];
            
        }
        if (_player.position.x<selfAnchorPosition+160) {
            float f;
            float f2;
            f = selfAnchorPosition +160 - _player.position.x;
            CCLOG(@"f = %f",f);
            if (f>100) {
                f = 100;
            }
            f2 = f*f;
            CCLOG(@"f2 = %f",f2);
            f =  f2/10000;
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
        
        
        for (CCNode * enemy in _arrayEnemyPig) {
            if (enemy.position.x - selfAnchorPosition > 0 &&  enemy.position.x -selfAnchorPosition < 800) {
                enemy.physicsBody.density = 100;
                enemy.physicsBody.friction = 100;
                //  mouse.paused = YES;
            }
        }
        for (CCNode * enemy in _arrayEnemyBat) {
            if (enemy.position.x - selfAnchorPosition > 0 &&  enemy.position.x -selfAnchorPosition < 800) {
                enemy.physicsBody.density = 100;
                enemy.physicsBody.friction = 100;
                //  mouse.paused = YES;
            }
        }
        
        
        
        
    }
    /// Dialog tutorial
    
    if (_player.position.x > 1301 && tutorialStep ==0) {
        [[NSUserDefaults standardUserDefaults]setInteger:20 forKey:@"DialogInt"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.delegate touchToPaused:NO];
        tutorialStep = tutorialStep +1;
    }

    ///set create monster
    
    if (_player.position.x> 1543 && tutorialStep ==1)
    {
        [self createBat:ccp(1943, 300)];
        tutorialStep = tutorialStep +1;
    }
    if (_player.position.x >2100 && tutorialStep ==2) {
        [self createPig:ccp(2867, 285)];
        tutorialStep = tutorialStep +1;
    }
    
    if (_player.position.x > 3800 && tutorialStep ==3) {
        [self createPig:ccp(4450 , 51)];
        tutorialStep = tutorialStep+1;
    }

    ///control monster attack
    for (CCNode * enemy in _arrayEnemyBat) {
        if (enemy.position.x -_player.position.x <480 && enemy.position.x > selfAnchorPosition) {
            CCLOG(@"bat position = %f,%f",enemy.position.x,enemy.position.y);
            if (enemy.position.x -_player.position.x <300 && enemyAttackStep == 0) {
                CCLOG(@"intoFirstBat");
                if (enemy.parent) {
                    if (enemyAttackStep ==0 && enemy.position.y <160) {
                        CCLOG(@"1speed up!");
                        if (enemy.parent) [enemy.physicsBody applyImpulse:ccp(-200, 2500)];
                        enemyAttackStep =1;
                    }
                
                    if (enemyAttackStep ==1 && enemy.position.y <120){
                        enemyAttackStep =2;
                        [self scheduleBlock:^(CCTimer *timer) {
                            if (enemy.parent) [enemy.physicsBody applyImpulse:ccp(-200, 1500)];
                        } delay:1.0f];

                        CCLOG(@"2speed up!");
 
                    }
                    if (enemyAttackStep ==2 && enemy.position.y < 100){
                        if (enemy.parent) [enemy.physicsBody applyImpulse:ccp(-200, 2000)];
                        CCLOG(@"3speed up!");
                        return;
                    }

                }
                
                    
                
                
            }
        }
    }
    
    for (CCNode * enemy in _arrayEnemyPig) {
        if (enemy.position.x - selfAnchorPosition < 480 && enemy.position.x > selfAnchorPosition) {
            if (enemy.position.x -selfAnchorPosition < -100) {
                [enemy removeFromParentAndCleanup:YES];
            }
            if(enemyEnableJump){
                CCLOG(@"pig can jump!");
                int a = arc4random()%7;
                    if (a == 1) {
                        CCLOG(@"pig Jump!!");
                        if (enemy.parent) {
                    [enemy.physicsBody applyImpulse:ccp(-200, 2000)];
                        }
                    }
                }
        }
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
    if((_player.position.y<-40))
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
    if(_player.position.x < selfAnchorPosition-40 )
    {
        [_player removeFromParent];
        [self.delegate appearFailCount];
    }
    
    
    ///completegame
    if ((_player.position.x > 5300 && !endgame )) {
        endgame = YES;
        deltaStop = YES;
        skillPosition.x = _player.position.x;
        [self.delegate showClearCount];
        [self.delegate buttonControl:NO];
        [[NSUserDefaults standardUserDefaults]setInteger:20 forKey:@"DialogInt"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    ////////////player & layer position
    
    if (![self.delegate getPaused] && !deltaStop) {
        if ((_player.position.x-_playerY.x)<1) {
            [_player.physicsBody applyForce:ccp(6500.0f *delta, 0.0f)];
            self.position = ccp(self.position.x - 50*delta, self.position.y);
            selfAnchorPosition = selfAnchorPosition +50*delta;
            CCLOG(@"11111");
        }else{
            self.position = ccp(self.position.x - 100*delta, self.position.y);
            selfAnchorPosition = selfAnchorPosition + 100*delta;
            CCLOG(@"2");
        }
    }
    if (deltaStop) {
        self.position = ccp(self.position.x, self.position.y);
    }
 /*   if(_sFire)
    {
        _sFire.position = ccp(_player.position.x+25,1000);
    }
 */   CCLOG(@"_sFire.position = %f,%f",_sFire.position.x,_sFire.position.y);
    _playerY = ccp(_player.position.x, _player.position.y);
    
    CCLOG(@"_player.position.x = %f\n _playerY.position.x = %f",_player.position.x,_playerY.x);
    CCLOG(@"ancherpoint = %f",selfAnchorPosition);
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
                    [oal playEffect:@"sabersMusic.caf"];
                }
                break;
            }
            case 1:
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
                    [oal playEffect:@"lancerSMusic.caf"];
                }
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
                _skillBG.position = ccp(selfAnchorPosition, 0); //load From ccb skillBG
                _skillBG.visible = YES;
                
                skillPosition = ccp(_player.position.x, _player.position.y);
                [self.delegate transMpDecrease:9];
                [_player.physicsBody applyImpulse:ccp(0, 700)];
                [_player.userObject runAnimationsForSequenceNamed:@"Skill"];
                [self scheduleBlock:^(CCTimer *timer) {
                    [self.delegate scrollViewShake];
                    CCNode * skillBombccp = [CCBReader load:@"skillCCPSaberTwo"];
                    skillBombccp.position = ccp(_player.position.x +140, _player.position.y);
                    [self addChild:skillBombccp];
                    
                    CCNode * skillBombccpo = [CCBReader load:@"skillCCPSaberTwo"];
                    skillBombccpo.position = ccp(_player.position.x +220, _player.position.y);
                    [self addChild:skillBombccpo];
                    
                    CCNode * skillBombccpa = [CCBReader load:@"skillCCPSaberTwo"];
                    skillBombccpa.position = ccp(_player.position.x +300, _player.position.y);
                    [self addChild:skillBombccpa];
                    
                    [self createSkillShot];
                    
                    [self scheduleBlock:^(CCTimer *timer) {
                        
                        if (_skillFire.parent) {[_skillFire.physicsBody applyImpulse:ccp(10000, 0)];}
                    } delay:0.3];
                } delay:1.0f ];
                [self scheduleBlock:^(CCTimer *timer) {
                    deltaStop = NO;
                    [oal playEffect:@"exp.caf" volume:5 pitch:1.0f pan:0.0f loop:NO];;
                    [self scheduleBlock:^(CCTimer *timer) {
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
                _skillBG.position = ccp(selfAnchorPosition, 0); //load From ccb skillBG
                _skillBG.visible = YES;
                
                skillPosition = ccp(_player.position.x, _player.position.y);
                [self.delegate transMpDecrease:9];
                [_player.physicsBody applyImpulse:ccp(0, 700)];
                [_player.userObject runAnimationsForSequenceNamed:@"Skill"];
                [self scheduleBlock:^(CCTimer *timer) {
                    [oal playEffect:@"lancerSkMusic.caf"];
                    
                    [self createSkillShot];
                    
                    [self scheduleBlock:^(CCTimer *timer) {
                    [oal playEffect:@"exp.caf" volume:5 pitch:1.0f pan:0.0f loop:NO];
                        [self.delegate scrollViewShake];
                        
                    } delay:1.0f];
                } delay:1.0f ];
                [self scheduleBlock:^(CCTimer *timer) {
                    deltaStop = NO;
                    [self scheduleBlock:^(CCTimer *timer) {
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
                _skillBG.position = ccp(selfAnchorPosition, 0); //load From ccb skillBG
                _skillBG.visible = YES;
                
                skillPosition = ccp(_player.position.x, _player.position.y);
                [self.delegate transMpDecrease:9];
                //[_player.physicsBody applyImpulse:ccp(0, 700)];
                [_player.userObject runAnimationsForSequenceNamed:@"Skill"];
                [self scheduleBlock:^(CCTimer *timer) {

                    [oal playEffect:@"archerSKM.caf"];
                    [self createSkillShot];
                    
                } delay:1.0f ];
                [self scheduleBlock:^(CCTimer *timer) {
                    deltaStop = NO;
                    [self scheduleBlock:^(CCTimer *timer) {
                        _skillBG.visible = NO;
                    } delay:0.8];
                    
                } delay:1.5];
            }
        }
            break;
    }
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

-(void)ccPhysicsCollisionSeparate:(CCPhysicsCollisionPair *)pair Player:(CCNode *)nodeA blueGnd:(CCNode *)nodeB
{
    enableJump = NO;
    
}

-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair enemy:(CCNode *)nodeA blueGnd:(CCNode *)nodeB
{
    enemyEnableJump = YES;
    return YES;
}
-(void)ccPhysicsCollisionSeparate:(CCPhysicsCollisionPair *)pair enemy:(CCNode *)nodeA blueGnd:(CCNode *)nodeB
{
    enemyEnableJump = NO;
    
}
-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair Player:(CCNode *)nodeA enemy:(CCNode *)nodeB
{
    CCLOG(@"player collision bat!!");
    if (nodeA.parent){   [nodeA.physicsBody applyImpulse:ccp(-200,100)];}
    if (nodeB.parent)
    {
        nodeB.position = ccp(nodeB.position.x, nodeB.position.y+50);
        [self scheduleBlock:^(CCTimer *timer) {
            if (nodeB.parent)[nodeB.physicsBody applyImpulse:ccp(-100, 600)];
        } delay:0.1f];
    }
    return YES;
}
-(void) ccPhysicsCollisionSeparate:(CCPhysicsCollisionPair *)pair Player:(CCNode *)nodeA enemy:(CCNode *)nodeB
{
    [self.delegate transHpDecrease:2];
    
}
-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair slFire:(CCNode *)nodeA Stone:(CCNode *)nodeB
{
    
    if (bRHP <2) {
  
    bRHP = bRHP +1;
        CCLOG(@"brhp = %d",bRHP);

    }
    return YES;
}

-(void)ccPhysicsCollisionSeparate:(CCPhysicsCollisionPair *)pair slFire:(CCNode *)nodeA Stone:(CCNode *)nodeB
{
    if (bRHP<2) {
        //if (nodeB.parent) [nodeB.physicsBody applyImpulse:ccp(500 , 200)];
    }
    if (bRHP == 2) {
        [nodeB removeFromParent];
        bRHP = 0;
    }
    CCLOG(@"separate brhp = %d",bRHP);
}
-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair slFire:(CCNode *)nodeA enemy:(CCNode *)nodeB
{
    [nodeB removeFromParent];
    return YES;
}
-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair skillFire:(CCNode *)nodeA enemy:(CCNode *)nodeB
{
    [nodeB removeFromParent];
    [nodeA removeFromParent];
    CCLOG(@"skillshot");
    return YES;
}
-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair skillFire:(CCNode *)nodeA Stone:(CCNode *)nodeB
{
    [nodeA removeFromParent];
    
    [nodeB removeFromParent];
    return YES;
}
-(float) getSelfAnchorPosition
{
    return selfAnchorPosition;
}
-(BOOL) getDeltaStop
{
    return deltaStop;
}

-(void)onExit {
    [oal stopEverything];
    [oal stopAllEffects];
    [oal unloadAllEffects];
    [self stopAllActions];
    [_arrayEnemyBat removeAllObjects];
    [_arrayEnemyPig removeAllObjects];
    [_arrayGnd removeAllObjects];
    
    [self unscheduleAllSelectors];
    
    [self removeAllChildrenWithCleanup:YES];
    //
    CCLOG(@"Onexit");
    [super onExit];
}

@end
