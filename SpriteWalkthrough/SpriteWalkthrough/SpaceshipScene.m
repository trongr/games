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

    SKSpriteNode* spaceship = [self newSpaceship];
    spaceship.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:spaceship];
    
    SKAction *makeRocks = [SKAction sequence: @[
                                                [SKAction performSelector:@selector(addRock) onTarget:self],
                                                [SKAction waitForDuration:0.10 withRange:0.15]
                                                ]];

    [self runAction: [SKAction repeatActionForever:makeRocks]];
}

-(void)didSimulatePhysics
{
    [self enumerateChildNodesWithName:@"rock" usingBlock:^(SKNode *node, BOOL *stop) {
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
    node.name = @"rock";
    node.position = CGPointMake(skRand(0, self.size.width), self.size.height);
    [node setSize:size];
    node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:size];
    node.physicsBody.usesPreciseCollisionDetection = YES;
    
    SKAction *rotate = [SKAction rotateByAngle:M_PI*2 duration:1];
    [node runAction: [SKAction repeatActionForever:rotate]];
    
    [self addChild:node];
}

-(SKSpriteNode*)newSpaceship {
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:@"spaceship.png"];
    
    node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:node.size];
    node.physicsBody.dynamic = NO;
    
    SKAction *rotate = [SKAction rotateByAngle:M_PI*2 duration:2.0];
    SKAction *seq = [SKAction sequence:@[
                                         [SKAction moveByX:100 y:200 duration:1.0],
                                         [SKAction waitForDuration:1.0],
                                         [SKAction moveByX:-100.0 y:-200 duration:2]
                                         ]];
    SKAction *group = [SKAction group:@[rotate, seq]];
    
    [node runAction: [SKAction repeatActionForever:group]];

    return node;
}

-(SKSpriteNode*)newLight {
    SKSpriteNode *light = [[SKSpriteNode alloc] initWithColor:[SKColor yellowColor] size:CGSizeMake(10, 10)];
    SKAction *blink = [SKAction sequence:@[
        [SKAction fadeOutWithDuration:0.25],
        [SKAction fadeInWithDuration:0.25]]];
    SKAction *blinkForever = [SKAction repeatActionForever:blink];
    [light runAction: blinkForever];
    return light;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    SKScene *spriteScene  = [[SpriteScene alloc] initWithSize:self.size];
    SKTransition *doors = [SKTransition fadeWithColor:[SKColor whiteColor] duration:0.5];
    [self.view presentScene:spriteScene transition:doors];
}

@end
