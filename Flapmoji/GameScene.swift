//
//  GameScene.swift
//  Flapmoji
//
//  Created by bald on 2/15/18.
//  Copyright © 2018 B0RN BKLYN Inc. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var bird = SKSpriteNode()
   
    override func didMove(to view: SKView) {
        
        let backgroundTexture = SKTexture(imageNamed: "bg.png")
        
        let moveBGAnimation = SKAction.move(by: CGVector(dx: -backgroundTexture.size().width, dy:0), duration: 7)
        let shiftBGAnimation = SKAction.move(by: CGVector(dx:backgroundTexture.size().width, dy:0 ), duration: 0)
        let moveBGForever = SKAction.repeatForever(SKAction.sequence([moveBGAnimation, shiftBGAnimation]))
        
        var i: CGFloat  = 0
        
        while i < 3 {
            
        let background = SKSpriteNode(texture: backgroundTexture)
        
        
        background.position = CGPoint(x: backgroundTexture.size().width * i, y: self.frame.midY)
        background.size.height = self.frame.height
        background.run(moveBGForever)
        
        background.zPosition = -1
        self.addChild(background)
        
        i += 1
            
        }
            
        let birdTexture = SKTexture(imageNamed: "flappy1.png")
        let birdTexture2 = SKTexture(imageNamed: "flappy2.png")
        
        let animation = SKAction.animate(with: [birdTexture, birdTexture2], timePerFrame: 0.1)
        let makeBirdFlap = SKAction.repeatForever(animation)
        
        bird = SKSpriteNode(texture: birdTexture)
        
        
        bird.position = CGPoint(x: self.frame.midX , y: self.frame.midY)
        bird.run(makeBirdFlap)
        
        self.addChild(bird)
        
        let ground = SKNode()
        ground.position = CGPoint(x: self.frame.midX, y: -self.frame.height/2)
        
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 2))
        ground.physicsBody!.isDynamic = false
        
        self.addChild(ground)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let birdTexture = SKTexture(imageNamed: "flappy1.png")
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height/2)

        bird.physicsBody!.isDynamic = true
        bird.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
        bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 75))

    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
