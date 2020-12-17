//
//  Player.h
//  Jerboable
//
//  Created by Kevin Lunden on 11/29/20.
//  Copyright (c) 2020 Razeware, LLC. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Player : SKSpriteNode
@property (nonatomic, assign) CGPoint velocity;
- (void)update:(NSTimeInterval)delta;
-(CGRect)collisionBoundingBox;
@property (nonatomic, assign) CGPoint desiredPosition;
@property (nonatomic, assign) BOOL onGround;
@property (nonatomic, assign) BOOL forwardMarch;
@property (nonatomic, assign) BOOL mightAsWellJump;
@end


