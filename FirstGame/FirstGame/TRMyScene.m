//
//  TRMyScene.m
//  FirstGame
//
//  Created by Michael T on 2014-10-28.
//  Copyright (c) 2014 Intense Noodles. All rights reserved.
//

#import "TRMyScene.h"

@implementation TRMyScene {
    SKNode* _bglayer;
    SKNode* _gamelayer;
    SKNode* _hudlayer;
    NSTimeInterval* _dt;
    NSTimeInterval* _lastupdatetime;
}

NSString* const BG = @"bg";
const int NUMBG = 2; // more if the screen is much larger than the background width
const float BGSCALE = 0.65;
const int MOVEBGDURATION = 5;

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        _bglayer = [SKNode node];
        [self addChild:_bglayer];
        _gamelayer = [SKNode node];
        [self addChild:_gamelayer];
        _hudlayer = [SKNode node];
        [self addChild:_hudlayer];
        
        SKTexture* bg = [SKTexture textureWithImageNamed:BG];
        for (int i=0; i < NUMBG; i++) {
            SKSpriteNode* sprite = [SKSpriteNode spriteNodeWithTexture:bg];
            [sprite setScale:BGSCALE];
            sprite.zPosition = -1;
            sprite.anchorPoint = CGPointZero;
            sprite.position = CGPointMake(i * sprite.size.width, 0);
            
            SKAction* movebg = [SKAction moveByX:-sprite.size.width y:0 duration:MOVEBGDURATION];
            SKAction* resetbg = [SKAction moveByX:sprite.size.width y:0 duration:0];
            SKAction* movebgforever = [SKAction repeatActionForever:[SKAction sequence:@[movebg, resetbg]]];
            
            [sprite runAction:movebgforever];
            [_bglayer addChild:sprite];
        }
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    /* Called when a touch begins */
//    
//    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
//        
//        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
//        
//        sprite.position = location;
//        
//        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
//        
//        [sprite runAction:[SKAction repeatActionForever:action]];
//        
//        [self addChild:sprite];
//    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
