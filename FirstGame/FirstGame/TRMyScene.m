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

NSString* const PLAYER = @"player";
const int PLAYER_WIDTH = 50;

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        self.physicsWorld.gravity = CGVectorMake(0.0, -5.0);
        self.physicsWorld.contactDelegate = self;
        
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
            sprite.zPosition = 0;
            sprite.anchorPoint = CGPointZero;
            sprite.position = CGPointMake(i * sprite.size.width, 0);
            
            SKAction* moveground = [SKAction moveByX:-sprite.size.width y:0 duration:MOVEGROUNDDURATION];
            SKAction* resetground = [SKAction moveByX:sprite.size.width y:0 duration:0];
            SKAction* movegroundforever = [SKAction repeatActionForever:[SKAction sequence:@[moveground, resetground]]];
            
            [sprite runAction:movegroundforever];
            [_gamelayer addChild:sprite];
        }

        _player = [SKSpriteNode spriteNodeWithImageNamed:PLAYER];
        _player.position = CGPointMake(60, 400);
        _player.zPosition = 0;
        _player.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(PLAYER_WIDTH, PLAYER_WIDTH)];
        _player.physicsBody.dynamic = YES;
        _player.physicsBody.allowsRotation = NO;
        _player.physicsBody.categoryBitMask = planecategory;
        _player.physicsBody.collisionBitMask = worldcategory | pipecategory | skycategory;
        _player.physicsBody.contactTestBitMask = worldcategory | pipecategory | skycategory;
        [_gamelayer addChild:_player];
        
        SKNode* dummyground = [SKNode node];
        dummyground.position = CGPointMake(0, ground.size.height * GROUNDSCALE);
        dummyground.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.frame.size.width, 1)];
        dummyground.physicsBody.dynamic = NO;
        dummyground.physicsBody.categoryBitMask = worldcategory;
        [_gamelayer addChild:dummyground];
 
        SKNode* dummyceiling = [SKNode node];
        dummyceiling.position = CGPointMake(0, self.size.height);
        dummyceiling.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.size.width, 1)];
        dummyceiling.physicsBody.dynamic = NO;
        dummyceiling.physicsBody.categoryBitMask = skycategory;
        [_gamelayer addChild:dummyceiling];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    _player.physicsBody.velocity = CGVectorMake(0, 0);
    [_player.physicsBody applyImpulse:CGVectorMake(0, 30)];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
