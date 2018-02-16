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
   
    @objc func makePipes(){
        let gapHeight = bird.size.height * 5
        
        let movementAmount = arc4random() % UInt32(self.frame.height / 2)
        let pipeOffset = CGFloat(movementAmount) - self.frame.height / 4
        
        let pipeTexture1 = SKTexture(imageNamed: "pipe1.png")
        let pipe1 = SKSpriteNode(texture: pipeTexture1)
        pipe1.position = CGPoint(x: self.frame.midX + self.frame.width, y: self.frame.midY + pipeTexture1.size().height/2 + gapHeight/2 + pipeOffset)
        
        let pipeTexture2 = SKTexture(imageNamed: "pipe2.png")
        let pipe2 = SKSpriteNode(texture: pipeTexture2)
        pipe2.position = CGPoint(x: self.frame.midX + self.frame.width, y: self.frame.midY - pipeTexture2.size().height/2 - gapHeight/2 + pipeOffset)
        
        let movePipes = SKAction.move(by: CGVector(dx: -2 * self.frame.width, dy: 0), duration: TimeInterval(self.frame.width / 100))
        pipe1.run(movePipes)
        pipe2.run(movePipes)
        
        self.addChild(pipe1)
        self.addChild(pipe2)
        
        
    }
    
    override func didMove(to view: SKView) {
        
        _ = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.makePipes), userInfo: nil, repeats: true)
        
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
