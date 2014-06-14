//
//  GameScene.swift
//  SwiftBreaker
//
//  Created by Jake Januzelli on 6/9/14.
//  Copyright (c) 2014 Jake Januzelli. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    init(size: CGSize) {
        super.init(size: size)
        
        // make an extension with easy SKNode factory methods
        
        let brick = SKSpriteNode(color: UIColor.orangeColor(), size: CGSize(width: 80, height: 50))
        brick.position = CGPoint(x: CGRectGetMidX(self.frame) , y: CGRectGetMidY(self.frame))
        brick.name = "Brick"
        self.addChild(brick)
        
        let paddle = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 60, height: 10))
        paddle.position = CGPoint(x: CGRectGetMidX(self.frame), y: 100)
        paddle.name = "Paddle"
        self.addChild(paddle)
        
        let ball = SKShapeNode(circleOfRadius: 5)
        ball.fillColor = UIColor.whiteColor()
        ball.position = CGPoint(x: CGRectGetMidX(self.frame), y: 110)
        ball.name = "Ball"
        
        // constrains the ball to ricochet off the sides of the screen
        let ricochet = SKConstraint.positionX(SKRange(lowerLimit: 0, upperLimit: self.frame.width), y: SKRange(lowerLimit: 0, upperLimit: self.frame.height))
        ball.constraints = [ricochet]
        
        self.addChild(ball)
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
