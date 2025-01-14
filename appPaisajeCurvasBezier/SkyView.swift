//
//  SkyView.swift
//  appPaisajeCurvasBezier
//
//  Created by braulio on 07/06/24.
//  Copyright © 2024 braulio. All rights reserved.
//

import UIKit

class SkyView: UIView {
    private var rageLevel: RageLevel = .caperucita
    private var caperucitaImageView: UIImageView!


    func setRageLevel(_ rageLevel: RageLevel) {
        self.rageLevel = rageLevel
        setNeedsDisplay()
    }

    private func degreesToRadians(_ degrees: CGFloat) -> CGFloat {
        return CGFloat.pi * degrees/180.0
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        let colorSpace = CGColorSpaceCreateDeviceRGB()

        drawSky(in: rect, rageLevel: rageLevel, context: context, colorSpace: colorSpace)
        drawSun(in: rect, context: context)
        drawMountains(in: rect, in: context, with: colorSpace)
        drawGrass(in: rect, in: context, with: colorSpace)
        drawFlowers(in: rect, in: context, with: colorSpace)
        drawClouds(in: rect, context: context)
        
        if rageLevel == .caperucita {
            addCaperucita(in: rect)
        } else {
            caperucitaImageView?.removeFromSuperview()
            caperucitaImageView = nil
        }
    }

    private func drawSky(in rect: CGRect, rageLevel: RageLevel, context: CGContext, colorSpace: CGColorSpace) {
        let baseColor: UIColor
        let middleStop: UIColor
        let farStop: UIColor

        switch rageLevel {
        case .caperucita:
            baseColor = UIColor(red: 0 / 255.0, green: 158.0 / 255.0, blue: 183.0 / 255.0, alpha: 1.0)
            middleStop = UIColor(red: 0.0 / 255.0, green: 255.0 / 255.0, blue: 252.0 / 255.0, alpha: 1.0)
            farStop = UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
        case .lobo:
            baseColor = UIColor(red: 255.0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 1.0)
            middleStop = UIColor(red: 140.0 / 255.0, green: 33.0 / 255.0, blue: 33.0 / 255.0, alpha: 1.0)
            farStop = UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 1.0)

        
        }

        context.saveGState()
        defer { context.restoreGState() }

        let gradientColors = [baseColor.cgColor, middleStop.cgColor, farStop.cgColor]
        let locations: [CGFloat] = [0.0, 0.1, 0.25]

        let startPoint = CGPoint(x: rect.size.height/2, y: 0)
        let endPoint = CGPoint(x: rect.size.height/2, y: rect.size.width)

        if let gradient = CGGradient.init(colorsSpace: colorSpace, colors: gradientColors as CFArray, locations: locations) {
            context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
        }
    }

    private func drawSun(in rect: CGRect, context: CGContext) {
        let sunColor = UIColor.yellow
        let sunCenter = CGPoint(x: rect.size.width * 0.8, y: rect.size.height * 0.2)
        let sunRadius: CGFloat = 50

        context.saveGState()
        defer { context.restoreGState() }

        context.setFillColor(sunColor.cgColor)
        context.addArc(center: sunCenter, radius: sunRadius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        context.fillPath()
    }

    private func drawMountains(in rect: CGRect, in context: CGContext, with colorSpace: CGColorSpace?) {
        let darkColor = UIColor(red: 1.0 / 255.0, green: 93.0 / 255.0, blue: 67.0 / 255.0, alpha: 1)
        let lightColor = UIColor(red: 63.0 / 255.0, green: 109.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
        let rectWidth = rect.size.width

        let mountainColors = [darkColor.cgColor, lightColor.cgColor]
        let mountainLocations: [CGFloat] = [0.1, 0.2]
        guard let mountainGrad = CGGradient.init(colorsSpace: colorSpace, colors: mountainColors as CFArray, locations: mountainLocations) else {
            return
        }

        let mountainStart = CGPoint(x: rect.size.height / 2, y: 100)
        let mountainEnd = CGPoint(x: rect.size.height / 2, y: rect.size.width)

        context.saveGState()
        defer { context.restoreGState() }

        let backgroundMountains = CGMutablePath()
        backgroundMountains.move(to: CGPoint(x: -5, y: 157), transform: .identity)
        backgroundMountains.addQuadCurve(to: CGPoint(x: 77, y: 157), control: CGPoint(x: 30, y: 129), transform: .identity)
        backgroundMountains.addCurve(to: CGPoint(x: 303, y: 125), control1: CGPoint(x: 190, y: 210), control2: CGPoint(x: 200, y: 70), transform: .identity)
        backgroundMountains.addQuadCurve(to: CGPoint(x: 350, y: 150), control: CGPoint(x: 340, y: 150), transform: .identity)
        backgroundMountains.addQuadCurve(to: CGPoint(x: 410, y: 145), control: CGPoint(x: 380, y: 155), transform: .identity)
        backgroundMountains.addCurve(to: CGPoint(x: rectWidth, y: 165), control1: CGPoint(x: rectWidth - 90, y: 100), control2: CGPoint(x: rectWidth - 50, y: 190), transform: .identity)
        backgroundMountains.addLine(to: CGPoint(x: rectWidth - 10, y: rect.size.width), transform: .identity)
        backgroundMountains.addLine(to: CGPoint(x: -5, y: rect.size.width), transform: .identity)
        backgroundMountains.closeSubpath()

        // Background Mountain Drawing
        context.addPath(backgroundMountains)

        context.clip()
        context.drawLinearGradient(mountainGrad, start: mountainStart, end: mountainEnd, options: [])
        context.setLineWidth(4)

        // Background Mountain Stroking
        context.addPath(backgroundMountains)
        context.setStrokeColor(UIColor.black.cgColor)
        context.strokePath()

        // Foreground Mountains
        let foregroundMountains = CGMutablePath()
        foregroundMountains.move(to: CGPoint(x: -5, y: 190), transform: .identity)
        foregroundMountains.addCurve(to: CGPoint(x: 303, y: 190), control1: CGPoint(x: 160, y: 250), control2: CGPoint(x: 200, y: 140), transform: .identity)
        foregroundMountains.addCurve(to: CGPoint(x: rectWidth, y: 210), control1: CGPoint(x: rectWidth - 150, y: 250), control2: CGPoint(x: rectWidth - 50, y: 170), transform: .identity)
        foregroundMountains.addLine(to: CGPoint(x: rectWidth, y: 230), transform: .identity)
        foregroundMountains.addCurve(to: CGPoint(x: -5, y: 225), control1: CGPoint(x: 300, y: 260), control2: CGPoint(x: 140, y: 215), transform: .identity)
        foregroundMountains.closeSubpath()

        // Foreground Mountain drawing
        context.addPath(foregroundMountains)
        context.clip()
        context.setFillColor(darkColor.cgColor)
        context.fill(CGRect(x: 0, y: 170, width: rectWidth, height: 90))

        // Foreground Mountain stroking
        context.addPath(foregroundMountains)
        context.setStrokeColor(UIColor.black.cgColor)
        context.strokePath()
    }

    private func drawGrass(in rect: CGRect, in context: CGContext, with colorSpace: CGColorSpace?) {
        context.saveGState()
        defer { context.restoreGState() }

        let grassStart = CGPoint(x: rect.size.height / 2, y: 100)
        let grassEnd = CGPoint(x: rect.size.height / 2, y: rect.size.width)
        let rectWidth = rect.size.width

        let grass = CGMutablePath()
        grass.move(to: CGPoint(x: rectWidth, y: 230), transform: .identity)
        grass.addCurve(to: CGPoint(x: 0, y: 225), control1: CGPoint(x: 300, y: 260), control2: CGPoint(x: 140, y: 215), transform: .identity)
        grass.addLine(to: CGPoint(x: 0, y: rect.size.width), transform: .identity)
        grass.addLine(to: CGPoint(x: rectWidth, y: rect.size.width), transform: .identity)

        context.addPath(grass)
        context.clip()

        let lightGreen = UIColor(red: 39.0 / 255.0, green: 171.0 / 255.0, blue: 95.0 / 255.0, alpha: 1)
        let darkGreen = UIColor(red: 0.0 / 255.0, green: 134.0 / 255.0, blue: 61.0 / 255.0, alpha: 1)

        let grassColors = [lightGreen.cgColor, darkGreen.cgColor]
        let grassLocations: [CGFloat] = [0.3, 0.4]
        if let grassGrad = CGGradient.init(colorsSpace: colorSpace, colors: grassColors as CFArray, locations: grassLocations) {
            context.drawLinearGradient(grassGrad, start: grassStart, end: grassEnd, options: [])
        }

        context.setLineWidth(1)
        context.setFillColor(UIColor.white.cgColor)
        context.setStrokeColor(UIColor.black.cgColor)
    }

    private func drawPetal(in rect: CGRect, inDegrees degrees: Int, inContext context: CGContext) {
        context.saveGState()
        defer { context.restoreGState() }

        let flowerPetal = CGMutablePath()

        let midX = rect.midX
        let midY = rect.midY

        let transform = CGAffineTransform(translationX: -midX, y: -midY).concatenating(CGAffineTransform(rotationAngle:
            degreesToRadians(CGFloat(degrees)))).concatenating(CGAffineTransform(translationX: midX, y: midY))

        flowerPetal.addEllipse(in: rect, transform: transform)
        context.addPath(flowerPetal)
        context.setStrokeColor(UIColor.black.cgColor)
        context.strokePath()
        context.setFillColor(UIColor.white.cgColor)
        context.addPath(flowerPetal)
        context.fillPath()
    }

    private func drawFlowers(in rect: CGRect, in context: CGContext, with colorSpace: CGColorSpace?) {
        context.saveGState()
        defer { context.restoreGState() }

        let flowerSize = CGSize(width: 300, height: 300)
        guard let flowerLayer = CGLayer(context, size: flowerSize, auxiliaryInfo: nil) else {
            return
        }

        guard let flowerContext = flowerLayer.context else {
            return
        }

        // Draw petals of the flower with varying colors
        let petalColors = [UIColor.white, UIColor.red, UIColor.blue, UIColor.purple, UIColor.yellow]

        for i in 0..<5 {
            flowerContext.setFillColor(petalColors[i].cgColor)
            drawPetal(in: CGRect(x: 125, y: 230, width: 9, height: 14), inDegrees: i * 72, inContext: flowerContext)
        }

        let center = CGMutablePath()
        let ellipse = CGRect(x: 126, y: 242, width: 6, height: 6)
        center.addEllipse(in: ellipse, transform: .identity)

        let orangeColor = UIColor(red: 255 / 255.0, green: 174 / 255.0, blue: 49.0 / 255.0, alpha: 1.0)

        // Draw flower center
        flowerContext.addPath(center)
        flowerContext.setStrokeColor(UIColor.black.cgColor)
        flowerContext.strokePath()
        flowerContext.setFillColor(orangeColor.cgColor)
        flowerContext.addPath(center)
        flowerContext.fillPath()
        flowerContext.move(to: CGPoint(x: 135, y: 249))
        context.setStrokeColor(UIColor.black.cgColor)
        flowerContext.addQuadCurve(to: CGPoint(x: 133, y: 270), control: CGPoint(x: 145, y: 250))
        flowerContext.strokePath()

        // Draw clones
        context.draw(flowerLayer, at: CGPoint(x: 0, y: 0))
        context.translateBy(x: 20, y: 10)
        context.draw(flowerLayer, at: CGPoint(x: 0, y: 0))
        context.translateBy(x: -30, y: 5)
        context.draw(flowerLayer, at: CGPoint(x: 0, y: 0))
        context.translateBy(x: -20, y: -10)
        context.draw(flowerLayer, at: CGPoint(x: 0, y: 0))
    }

    private func drawClouds(in rect: CGRect, context: CGContext) {
        context.saveGState()
        defer { context.restoreGState() }

        let cloudColor = UIColor.white
        let cloud1 = CGRect(x: rect.size.width * 0.3, y: rect.size.height * 0.1, width: 80, height: 40)
        let cloud2 = CGRect(x: rect.size.width * 0.6, y: rect.size.height * 0.15, width: 100, height: 50)
        let cloud3 = CGRect(x: rect.size.width * 0.5, y: rect.size.height * 0.05, width: 70, height: 35)

        context.setFillColor(cloudColor.cgColor)

        context.addEllipse(in: cloud1)
        context.addEllipse(in: cloud2)
        context.addEllipse(in: cloud3)
        context.fillPath()
    }
    
    private func addCaperucita(in rect: CGRect) {
        if caperucitaImageView == nil {
            let caperucitaImage = UIImage(named: "caperucita")!
            caperucitaImageView = UIImageView(image: caperucitaImage)
            caperucitaImageView.frame = CGRect(x: -caperucitaImage.size.width, y: rect.height - caperucitaImage.size.height - 50, width: caperucitaImage.size.width, height: caperucitaImage.size.height)
            addSubview(caperucitaImageView)
            animateCaperucita(in: rect)
        }
    }

    private func animateCaperucita(in rect: CGRect) {
        UIView.animate(withDuration: 5.0, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.caperucitaImageView.frame.origin.x = rect.width
        }, completion: nil)
    }
}

