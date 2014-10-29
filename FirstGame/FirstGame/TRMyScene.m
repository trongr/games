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
    SKSpriteNode* _player;
}

static const uint32_t planecategory = 1 << 0;
static const uint32_t worldcategory = 1 << 1;
static const uint32_t pipecategory = 1 << 2;
static const uint32_t scorecategory = 1 << 3;
static const uint32_t skycategory = 1 << 4;

NSString* const BG = @"bg";
const int NUMBG = 2; // more if the screen is much larger than the background width
const float BGSCALE = 0.65;
const int MOVEBGDURATION = 50;

NSString* const GROUND = @"ground";
const int NUMGROUND = 2; // more if the screen is much larger than the background width
const float GROUNDSCALE = 0.35;
const int MOVEGROUNDDURATION = 5;

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
        
        SKTexture* ground = [SKTexture textureWithImageNamed:GROUND];
        for (int i=0; i < NUMGROUND; i++) {
            SKSpriteNode* sprite = [SKSpriteNode spriteNodeWithTexture:ground];
            [sprite setScale:GROUNDSCALE];
            sprite.zPosition = -1;
            sprite.anchorPoint = CGPointZero;
            sprite.position = CGPointMake(i * sprite.size.width, 0);
            
            SKAction* moveground = [SKAction moveByX:-sprite.size.width y:0 duration:MOVEGROUNDDURATION];
            SKAction* resetground = [SKAction moveByX:sprite.size.width y:0 duration:0];
            SKAction* movegroundforever = [SKAction repeatActionForever:[SKAction sequence:@[moveground, resetground]]];
            
            [sprite runAction:movegroundforever];
            [_gamelayer addChild:sprite];
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
