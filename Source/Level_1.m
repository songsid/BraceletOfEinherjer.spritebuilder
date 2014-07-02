//
//  Level_1.m
//  NUTheNord
//
//  Created by Sid on 2014/3/17.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import "Level_1.h"

@implementation Level_1
-(void) didLoadFromCCB
{
    self.userInteractionEnabled = TRUE;
    _physicsNode.collisionDelegate = self; //set collisionDelegate
    
    
    _player = (CCNode *) [CCBReader load:@"PlayerSaber"];
    _player.position = ccp(20, 60);
    _player.anchorPoint = ccp(0.5f,0.5f);
    [_physicsNode addChild:_player];
    _player.physicsBody.collisionType = @"Player";

    _road.physicsBody.collisionType = @"Road";
    _road.physicsBody.elasticity = 0;
    _enemy = [CCBReader load:@"enemy"];
    _enemy.physicsBody.collisionType = @"enemy";
    _enemy.position = ccp(532, 43);
    CGRect a;
    a = CGRectMake( 200, 200,532, 60);
    _enemy.physicsBody = [CCPhysicsBody bodyWithPolylineFromRect:a cornerRadius:0];
    [_physicsNode addChild:_enemy];

    
    
    
    _sword.physicsBody.collisionType = @"Sword";
    
    CCLOG(@"%@",_enemy.physicsBody.collisionType);
}

-(void) update:(CCTime)delta
{
    if ((((_playerY.y - _player.position.y)<0.2f) && (_playerY.y - _player.position.y)>=0.0f) || ((_playerY.y - _player.position.y)>(-0.1f) && (_playerY.y - _player.position.y)<=0.0f)) {
        //CCLOG(@"Y==Y");
        enableJump = YES;
    }else{
        enableJump = NO;
        
    }

    _playerY = ccp(0, _player.position.y);
    
    
    
    _player.position = ccp(_player.position.x + 100*delta, _player.position.y);
    //CCLOG(@"\nposition = %f, %hhd",_player.position.y,enableJump);
    float xTarget = 80 - _player.position.x;
    CGPoint oldLayerPosition = self.position;
    
    float yNew = oldLayerPosition.y;
    float xNew = xTarget * 0.1 + oldLayerPosition.x * (1.0f - 0.1);
    
    self.position = ccp(xNew, yNew);
    

    
    ///EndGame/////////////////////////////////////////////////////////////
    if((_player.position.x > 3060 )||(_player.position.y<0))
    {
        [self.delegate popLevelScene];
        CCLOG(@"gameover!!!");
    }
    
}



-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (enableJump)
    {
        [_player.physicsBody applyImpulse:ccp(0,800.f)];
        [_player.userObject runAnimationsForSequenceNamed:@"Jump"];
    }
}
-(void)attack
{
   // CCLOG(@"attack");
    
    [_player.userObject runAnimationsForSequenceNamed:@"Attack"];
    CCLOG(@"%@",[_player.userObject runningSequenceName]);
    
    [self scheduleBlock:^(CCTimer *timer){
        CCNode * slamCCP = [CCBReader load:@"SlamCCP"];
        slamCCP.position = ccp(_player.position.x+39,_player.position.y);
        [self addChild:slamCCP];
    }delay:0.2f];
//##
 /*   Bana * banana = [[Bana alloc]init];
    
    banana.position =ccp(_player.position.x+50, _player.position.y+50);
    banana.anchorPoint = ccp(0.5f, 0.5f);
    [_physicsNode addChild:banana];
    [banana.physicsBody applyImpulse:ccp(300.0f, 0.0f)];
*/
/*    _attack = [CCBReader load:@"bana"];
    _attack.position = ccp(_player.position.x+50, _player.position.y+50);
    _attack.anchorPoint = ccp(0.5f,0.5f);
    [_physicsNode addChild:_attack];

    [_attack.physicsBody applyImpulse:ccp(300.0f, 0.f)];
    _attack.physicsBody.collisionType = @"Bana";
*/
    
}

-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair Bana:(CCNode *)nodeA enemy:(CCNode *)nodeB
{
    [nodeA removeFromParentAndCleanup:YES];
    [nodeB removeFromParentAndCleanup:YES];
    CCLOG(@"colision!!!!");
    return YES;
}



-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair Player:(CCNode *)nodeA enemy:(CCNode *)nodeB
{
    NSArray * anamation = [NSArray arrayWithObjects:[self.userObject runningSequenceName],nil];
    if (anamation.count ==2) {
        CCLOG(@"attack!!!!!!!!!!!!!!");
    }
    CCLOG(@"collision P E!!");
    return YES;
}
-(BOOL) ccPhysicsCollisionPreSolve:(CCPhysicsCollisionPair *)pair Player:(CCNode *)nodeA enemy:(CCNode *)nodeB
{
    if ([[_player.userObject runningSequenceName]isEqualToString:@"Attack"]) {
        CGPoint  point = ccp(nodeB.position.x,nodeB.position.y);
        [nodeB removeFromParent];
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

@end
