//
//  SpaceshipScene.m
//  SpriteWalkthrough
//
//  Created by Michael T on 2014-10-30.
//  Copyright (c) 2014 Intense Noodles. All rights reserved.
//

#import "SpaceshipScene.h"
#import "SpriteScene.h"

@interface SpaceshipScene ()
@property BOOL contentCreated;
@end

@implementation SpaceshipScene

NSString* const SPACESHIP = @"SPACESHIP";
NSString* const ROCK = @"ROCK";
const float GRAVITY = -9.8f / 9;
const float SHIP_THRUST = 1000;
const float SHIP_MASS = 10;
const float ROCK_MASS = 1;

NSString* const ROTATE_ACTION = @"ROTATE_ACTION";

- (void)didMoveToView:(SKView *)view
{
    if (!self.contentCreated)
    {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

- (void)createSceneContents
{
    self.backgroundColor = [SKColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;

    self.physicsWorld.gravity = CGVectorMake(0.0f, GRAVITY);

    SKSpriteNode* spaceship = [self newSpaceship];
    spaceship.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:spaceship];
    
//    SKAction *makeRocks = [SKAction sequence: @[
//                                                [SKAction performSelector:@selector(addRock) onTarget:self],
//                                                [SKAction waitForDuration:0.5 withRange:0.1]
//                                                ]];
//    
//    [self runAction: [SKAction repeatActionForever:makeRocks]];
}

-(void)didSimulatePhysics
{
    [self enumerateChildNodesWithName:ROCK usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.y < 0)
            [node removeFromParent];
    }];
}

// random point / number between low and high
static inline CGFloat skRand(CGFloat low, CGFloat high) {
    return rand() / (CGFloat) RAND_MAX * (high - low) + low;
}

- (void)addRock
{
    float w = skRand(30, 100);
    CGSize size = CGSizeMake(w, w);
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:@"rock.png"];
    node.name = ROCK;
    node.position = CGPointMake(skRand(0, self.size.width), self.size.height);
    [node setSize:size];
    node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:size];
    node.physicsBody.usesPreciseCollisionDetection = YES;
    node.physicsBody.mass = ROCK_MASS;
    
    SKAction *rotate = [SKAction rotateByAngle:M_PI*2 duration:1];
    [node runAction: [SKAction repeatActionForever:rotate]];
    
    [self addChild:node];
}

-(SKSpriteNode*)newSpaceship {
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:@"spaceship.png"];
    
    node.name = SPACESHIP;
    [node setScale:1.5];
    node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:node.size];
    node.physicsBody.affectedByGravity = NO;
    node.physicsBody.mass = SHIP_MASS;

    return node;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    SKNode *ship = [self childNodeWithName:SPACESHIP];
    CGPoint location = [[touches anyObject] locationInNode:self];
    
    float diffy = location.y - ship.position.y;
    float diffx = location.x - ship.position.x;
    float angle1 = ship.zRotation + M_PI_2;
    float angle2 = atan2f(diffy, diffx);
    angle1 = angle1 > M_PI ? -2 * M_PI + angle1 : angle1;
    float diffangle = angle2 - angle1;
    if (diffangle > M_PI){
        diffangle = -(2 * M_PI - diffangle);
    } else if (diffangle < -M_PI){
        diffangle = 2 * M_PI + diffangle;
    }

    [ship removeActionForKey:ROTATE_ACTION]; // stop previous rotating actions
    [ship runAction: [SKAction rotateByAngle:diffangle duration:0.5] withKey:ROTATE_ACTION];
    [ship.physicsBody applyImpulse:CGVectorMake(SHIP_THRUST * cosf(angle2), SHIP_THRUST * sinf(angle2))];

}

float degToRad(float degree) {
	return degree / 180.0f * M_PI;
}

@end
