//
//  Level00.m
//  BraceletOfEinherjar
//
//  Created by Sid on 2014/6/24.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import "Level00.h"
#import "LevelScene.h"
@implementation Level00

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
/*
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
*/
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
    
    _player = (CCNode *) [CCBReader load:@"PlayerArcherTest"];
    _player.position = ccp(80, 90);
    [_physicsNode addChild:_player z:1];

    /*
    _kake = (CCNode *) [CCBReader load:@"Kate"];
    _kake.position = ccp(0,50);
    _kake.scale = 0.8;
    _kake.physicsBody.collisionType = @"Kake";
    [_physicsNode addChild:_kake z:0];
    */
    
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
/*
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

    if (deltaStop) {
        self.position = ccp(self.position.x, self.position.y);
    }
    CCLOG(@"_sFire.position = %f,%f",_sFire.position.x,_sFire.position.y);
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
}*/

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
