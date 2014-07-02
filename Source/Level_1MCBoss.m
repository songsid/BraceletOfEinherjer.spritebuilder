//
//  Level_1MCBoss.m
//  NUTheNord
//
//  Created by Sid on 2014/5/17.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import "Level_1MCBoss.h"

@implementation Level_1MCBoss
-(NSMutableArray * )loopGnd
{
    if (!_loopGnd) {
        _loopGnd = [NSMutableArray array];
    }
    return _loopGnd;
}
-(NSMutableArray * )arrayOneStep
{
    if (!_arrayOneStep) {
        _arrayOneStep = [NSMutableArray array];
    }
    return _arrayOneStep;
}

-(void) didLoadFromCCB
{
    self.userInteractionEnabled = TRUE;
    
    _physicsNode.collisionDelegate = self; //set collisionDelegate
    mpDistance = 0.0f;
    bRHP = 0;
    createOneF = 0;
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

    
    _kake = (CCNode *) [CCBReader load:@"Kate"];
    _kake.position = ccp(0,50);
    _kake.scale = 0.8;
    _kake.physicsBody.collisionType = @"Kake";
    [_physicsNode addChild:_kake z:0];
    
    [self buildBludGnd:ccp(0, 0) :101];
    
    [self.loopGnd addObject:_mcBGnd1];
    [self.loopGnd addObject:_mcBGnd2];
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
-(void) createOne:(CGPoint)x
{
    _oneStep = (CCNode *)[CCBReader load:@"MCOneFloor"];
    _oneStep.position = x;
    _oneStep.physicsBody.collisionType = @"blueGnd";

    [_physicsNode addChild:_oneStep];

}
-(void) update:(CCTime)delta
{
    CCLOG(@"player.position = %f,%f",_player.position.x,_player.position.y);
    CCLOG(@"delta time = %f",delta);
    /////// player & layer position
    if (!deltaStop) {
        if (_player.position.x >= 160) {
            _player.position = ccp(160, _player.position.y);
        }else{
            
            float f;
            float f2;
            f = 160 - _player.position.x;
            CCLOG(@"f = %f",f);
            if (f>100) {
                f = 100;
            }
            f2 = f*f;
            CCLOG(@"f2 = %f",f2);
            f =  f2/10000;
            if ((_player.position.x-_playerY.x > 120 *delta) && f<1) {
                [_player.physicsBody applyForce:ccp(-2000.0f *delta, 0.0f)];
                CCLOG(@"+70 --ing");
            }else  {
                [_player.physicsBody applyForce:ccp(500.0f *delta * f, 0.0f)];
            }
        }
/*
 
        if ((_player.position.x -_playerY.x > delta) &&(_player.position.x <230) && (_player.position.x >160)) {
            [_player.physicsBody applyForce:ccp(-10000.0f *delta, 0.0f)];
            CCLOG(@"in --");
            
        }
        if ((_player.position.x -_playerY.x < delta)&&(_player.position.x <230)&& (_player.position.x >160))
        {
            [_player.physicsBody applyForce:ccp(10000.0f *delta, 0.0f)];
                        CCLOG(@"in ++");
        }
        if (_player.position.x>230) {
            float f;
            f = _player.position.x - 230;
            if (f>55) {
                f=55;
            }
            f = 1 + f*(-1/55);
            [_player.physicsBody applyForce:ccp(-1000.0f * delta * f, 0.0f)];
            
        }
        if (_player.position.x<160) {
            float f;
            float f2;
            f = 160 - _player.position.x;
            CCLOG(@"f = %f",f);
            if (f>100) {
                f = 100;
            }
            f2 = f*f;
            CCLOG(@"f2 = %f",f2);
            f =  f2/10000;
            if ((_player.position.x-_playerY.x > 120 *delta) && f<1) {
                [_player.physicsBody applyForce:ccp(-2000.0f *delta, 0.0f)];
                CCLOG(@"+70 --ing");
            }else  {
                [_player.physicsBody applyForce:ccp(500.0f *delta * f, 0.0f)];
            }
            
            CCLOG(@"Force = %f \n f=%f",6000*delta*f,f);
        }
    }else if (deltaStop){
      _player.position = ccp(skillPosition.x,_player.position.y);
*/      }
    ///// create 1f
    if (selfAnchorPosition > 1000 && createOneF==0) {
        int a = (int)selfAnchorPosition % 1000;
            if (a == 200) {
                [self createOne:ccp(600, 51)];
            }
    }
    if (_oneStep.position.x < 0) {
        [_oneStep removeFromParentAndCleanup:YES];
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
    ///
    if (![self.delegate getPaused] && !deltaStop) {
        if ((_player.position.x-_playerY.x)<0) {
            _mcBGnd1.position = ccp(_mcBGnd1.position.x - 50*delta, _mcBGnd1.position.y);
            _mcBGnd2.position = ccp(_mcBGnd2.position.x - 50*delta, _mcBGnd2.position.y);
            _oneStep.position = ccp(_oneStep.position.x -50*delta, _oneStep.position.y);
            selfAnchorPosition = selfAnchorPosition +50*delta;
        
            CCLOG(@"11111");
        }else{
            _mcBGnd1.position = ccp(_mcBGnd1.position.x - 100*delta, _mcBGnd1.position.y);
            _mcBGnd2.position = ccp(_mcBGnd2.position.x - 100*delta, _mcBGnd2.position.y);
            _oneStep.position = ccp(_oneStep.position.x -100*delta, _oneStep.position.y);
            selfAnchorPosition = selfAnchorPosition + 100*delta;
            CCLOG(@"2");
        }
    }
    if (deltaStop) {
        self.position = ccp(self.position.x, self.position.y);
    }
     _playerY = ccp(_player.position.x, _player.position.y);

    if (_mcBGnd1.position.x < -800) {
        _mcBGnd1.position = ccp(_mcBGnd2.position.x +780, _mcBGnd1.position.y);
    }
    if (_mcBGnd2.position.x < -800) {
        _mcBGnd2.position = ccp(_mcBGnd1.position.x +780, _mcBGnd2.position.y);
    }
    
    
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
}



-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    
 //   int dia = [[NSUserDefaults standardUserDefaults]integerForKey:@"DialogInt"];
   /* CCLOG(@"dialog int = %d",dia);
    CCLOG(@"levelscenepause = %hhd",[self.delegate getPaused]);
    if ([self.delegate getPaused]&& (dia>=10)&& dialogTouchOne) {
        [self.delegate removeDialog];
        self.userInteractionEnabled =YES;
        dialogTouchOne = NO;
        CCLOG(@"removedia");
    }
    */
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
        /*int dia = [[NSUserDefaults standardUserDefaults]integerForKey:@"DialogInt"];
        if ([self.delegate getPaused]&& (dia>=12)&& dialogButtonOne) {
            [self.delegate removeDialog];
            dialogButtonOne = NO;
            self.userInteractionEnabled = YES;
            CCLOG(@"removedia");
        }
        */
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
   //                 [[OALSimpleAudio sharedInstance] playEffect:@"slam3.mp3"];
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
    //                [[OALSimpleAudio sharedInstance] playEffect:@"slam3.mp3"];
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
                        [_skillFire.physicsBody applyImpulse:ccp(10000, 0)];
                    } delay:0.3];
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
                    
                    
                    [self createSkillShot];
                    
                    [self scheduleBlock:^(CCTimer *timer) {
                        [self.delegate scrollViewShake];
                        //     [_skillFire.physicsBody applyImpulse:ccp(10000, 0)];
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
        [nodeB.physicsBody applyImpulse:ccp(500 , 200)];
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
-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair SkillFire:(CCNode *)nodeA enemy:(CCNode *)nodeB
{
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
@end
