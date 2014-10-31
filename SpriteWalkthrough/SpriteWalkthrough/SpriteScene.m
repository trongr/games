//
//  SpriteScene.m
//  SpriteWalkthrough
//
//  Created by Michael T on 2014-10-30.
//  Copyright (c) 2014 Intense Noodles. All rights reserved.
//

#import "SpriteScene.h"

@interface SpriteScene ()
@property BOOL contentcreated;
@end

@implementation SpriteScene

-(void)didMoveToView:(SKView *)view {
    if (!self.contentcreated){
        [self createscenecontent];
        self.contentcreated = YES;
    }
}

NSString* const MYNODENAME = @"MYNODENAME";

-(void)createscenecontent {
    self.backgroundColor = [SKColor blueColor];
    self.scaleMode = SKSceneScaleModeAspectFill;
    [self addChild:[self newspritenode]];
}

-(SKLabelNode*)newspritenode {
    SKLabelNode* node = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypewriter"];
    node.name = MYNODENAME;
    node.text = @"hello y'all";
    node.fontSize = 42;
    node.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    return node;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    SKNode* node = [self childNodeWithName:MYNODENAME];
    if (node != nil){
        node.name = nil;
        SKAction* move = [SKAction moveByX:0 y:100 duration:0.5];
        SKAction* zoom = [SKAction scaleTo: 2.0 duration: 0.25];
        SKAction* pause = [SKAction waitForDuration: 0.5];
        SKAction* fade = [SKAction fadeOutWithDuration: 0.25];
        SKAction* remove = [SKAction removeFromParent];
        SKAction* seq = [SKAction sequence:@[move, zoom, pause, fade, remove]];
        [node runAction:seq];
    }
}

@end
