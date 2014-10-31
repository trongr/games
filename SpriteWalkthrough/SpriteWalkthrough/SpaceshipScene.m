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
    SKSpriteNode *spaceship = [self newSpaceship];
    spaceship.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:spaceship];
}

-(SKSpriteNode*)newSpaceship {
    SKSpriteNode* node = [[SKSpriteNode alloc] initWithColor:[SKColor greenColor] size:CGSizeMake(50, 50)];
    
    SKAction *rotate = [SKAction rotateByAngle:M_PI*2 duration:2.0];
    SKAction* move = [SKAction moveByX:100 y:200 duration:1.0];
    SKAction* pause = [SKAction waitForDuration:1.0];
    SKAction* back = [SKAction moveByX:-100.0 y:-200 duration:2];
    SKAction *seq = [SKAction sequence:@[move, pause, back]];
    SKAction *group = [SKAction group:@[rotate, seq]];
    
    [node runAction: [SKAction repeatActionForever:group]];
    return node;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    SKScene *spriteScene  = [[SpriteScene alloc] initWithSize:self.size];
    SKTransition *doors = [SKTransition fadeWithColor:[SKColor whiteColor] duration:0.5];
    [self.view presentScene:spriteScene transition:doors];
}

@end
