import RealityKit
import UIKit
import simd

enum MonumentSceneBuilder {
    static func build(into anchor: AnchorEntity) {
        let root = Entity()
        root.position = [0, -0.34, 0.05]
        anchor.addChild(root)

        buildLeftCitadel(in: root)
        buildRightCitadel(in: root)
        buildMidConnections(in: root)
        addHazeLayers(in: root)
        addAtmosphere(in: root)
    }

    static func addLights(into anchor: AnchorEntity) {
        let key = DirectionalLight()
        key.light.intensity = 20_500
        key.light.color = UIColor(hex: 0xFFD5E7)
        key.look(at: [0.2, 2.0, 0.0], from: [4.8, 8.5, 5.5], relativeTo: nil)
        anchor.addChild(key)

        let coolFill = DirectionalLight()
        coolFill.light.intensity = 5_600
        coolFill.light.color = UIColor(hex: 0x7C6CFF)
        coolFill.look(at: [0.0, 1.8, 0.0], from: [-5.2, 4.6, 2.5], relativeTo: nil)
        anchor.addChild(coolFill)

        let frontFill = PointLight()
        frontFill.light.intensity = 6_200
        frontFill.light.color = UIColor(hex: 0xF59BC8)
        frontFill.position = [0, 2.7, 8.2]
        anchor.addChild(frontFill)
    }

    private static func buildLeftCitadel(in parent: Entity) {
        let group = Entity()
        group.position = [-3.0, 0.0, 0.2]
        group.orientation = simd_quatf(angle: 0.24, axis: [0, 1, 0])
        parent.addChild(group)

        addBox(
            to: group,
            size: [2.34, 0.24, 2.34],
            position: [0.0, 0.12, 0.0],
            color: Palette.baseMid
        )
        addBox(
            to: group,
            size: [2.06, 4.35, 2.06],
            position: [0.0, 2.30, 0.0],
            color: Palette.baseDark
        )
        addBox(
            to: group,
            size: [2.22, 0.20, 2.22],
            position: [0.0, 3.96, 0.0],
            color: Palette.baseMid
        )
        addBox(
            to: group,
            size: [2.12, 0.16, 2.12],
            position: [0.0, 4.18, 0.0],
            color: Palette.baseLight
        )
        addBox(
            to: group,
            size: [2.10, 0.05, 2.10],
            position: [0.0, 2.64, 0.0],
            color: UIColor(hex: 0x8868D7, alpha: 0.62),
            cornerRadius: 0.012
        )
        addBox(
            to: group,
            size: [2.10, 0.05, 2.10],
            position: [0.0, 3.12, 0.0],
            color: UIColor(hex: 0x8C6CDA, alpha: 0.54),
            cornerRadius: 0.012
        )
        addCornerStuds(
            to: group,
            centerX: 0.0,
            centerZ: 0.0,
            span: 1.76,
            y: 2.68,
            size: 0.14,
            color: Palette.baseLight
        )
        addCornerStuds(
            to: group,
            centerX: 0.0,
            centerZ: 0.0,
            span: 1.76,
            y: 3.16,
            size: 0.12,
            color: UIColor(hex: 0x9A7CE3)
        )

        addBox(
            to: group,
            size: [1.35, 1.08, 1.35],
            position: [0.0, 4.83, 0.0],
            color: Palette.towerMid
        )
        addBox(
            to: group,
            size: [1.64, 0.20, 1.64],
            position: [0.0, 5.36, 0.0],
            color: Palette.towerLight
        )
        addDome(to: group, position: [0.0, 5.96, 0.0], radius: 0.56)

        let cornerOffsets: [SIMD3<Float>] = [
            [0.82, 5.22, 0.82],
            [-0.82, 5.22, 0.82],
            [0.82, 5.22, -0.82],
            [-0.82, 5.22, -0.82]
        ]
        cornerOffsets.forEach { addDome(to: group, position: $0, radius: 0.17) }

        let upperRamp = addBox(
            to: group,
            size: [2.02, 0.23, 0.56],
            position: [-1.22, 3.40, 0.76],
            color: Palette.bridgeTop
        )
        upperRamp.orientation = simd_quatf(angle: -0.29, axis: [0, 0, 1])
        addBox(
            to: group,
            size: [1.82, 0.03, 0.10],
            position: [-1.20, 3.53, 0.96],
            color: Palette.bridgeLight,
            cornerRadius: 0.008
        )

        let lowerRamp = addBox(
            to: group,
            size: [1.56, 0.21, 0.56],
            position: [-2.10, 2.68, 0.99],
            color: Palette.bridgeTop
        )
        lowerRamp.orientation = simd_quatf(angle: -0.23, axis: [0, 0, 1])
        addBox(
            to: group,
            size: [1.34, 0.03, 0.10],
            position: [-2.07, 2.80, 1.20],
            color: Palette.bridgeLight,
            cornerRadius: 0.008
        )

        addRampSteps(
            to: group,
            origin: [-1.95, 2.78, 1.06],
            count: 8,
            dx: 0.10,
            dy: 0.07
        )

        addBox(
            to: group,
            size: [1.94, 0.22, 0.66],
            position: [-1.16, 1.90, 1.43],
            color: Palette.bridgeMid
        )
        addBox(
            to: group,
            size: [1.44, 0.20, 0.60],
            position: [-0.18, 1.70, 1.58],
            color: Palette.bridgeTop
        )
        addBox(
            to: group,
            size: [1.20, 0.04, 0.10],
            position: [-0.18, 1.84, 1.81],
            color: Palette.bridgeLight,
            cornerRadius: 0.01
        )

        addPortal(
            to: group,
            center: [-1.14, 0.0, 1.42],
            span: 1.12,
            columnHeight: 1.92,
            depth: 0.28,
            color: Palette.baseDark
        )

        addPortal(
            to: group,
            center: [0.35, 0.0, 1.58],
            span: 0.82,
            columnHeight: 1.50,
            depth: 0.28,
            color: Palette.baseDark
        )

        addBox(
            to: group,
            size: [1.82, 2.42, 1.48],
            position: [-1.26, 1.21, 1.02],
            color: Palette.baseMid
        )

        addDoor(to: group, position: [-0.06, 3.12, 1.05], size: [0.24, 0.62, 0.05])
        addDoor(to: group, position: [-0.42, 1.95, 1.72], size: [0.20, 0.44, 0.05])
        addWindowSlit(to: group, position: [0.58, 2.4, 1.0], height: 0.24)
        addWindowSlit(to: group, position: [0.56, 1.72, 0.74], height: 0.24)
        addWindowSlit(to: group, position: [0.56, 1.12, 0.58], height: 0.24)
        addWallPatch(to: group, position: [0.61, 2.05, 0.9], size: [0.12, 0.06, 0.03])
        addWallPatch(to: group, position: [0.61, 1.49, 0.66], size: [0.11, 0.05, 0.03])
        addWallPatch(to: group, position: [0.60, 0.96, 0.50], size: [0.10, 0.05, 0.03])

        addAccentPad(to: group, position: [0.45, 1.83, 1.59], size: [0.20, 0.03, 0.20])
        addPost(to: group, position: [-2.26, 2.98, 1.18], height: 0.10)
        addPost(to: group, position: [-1.90, 3.24, 1.02], height: 0.10)

        addTraveler(
            to: group,
            position: [-1.54, 3.58, 0.79],
            bodyColor: UIColor(hex: 0xF3B06B),
            capeColor: UIColor(hex: 0x7D4AC8)
        )
        addTraveler(
            to: group,
            position: [-0.89, 3.28, 0.79],
            bodyColor: UIColor(hex: 0xF3566A),
            capeColor: UIColor(hex: 0xC74A8C)
        )

        addFlag(to: group, position: [0.10, 6.66, 0.03], scale: 1.03)
    }

    private static func buildRightCitadel(in parent: Entity) {
        let group = Entity()
        group.position = [3.0, 0.0, 0.12]
        group.orientation = simd_quatf(angle: -0.28, axis: [0, 1, 0])
        parent.addChild(group)

        addBox(
            to: group,
            size: [4.06, 0.34, 1.04],
            position: [0.05, 2.69, 0.02],
            color: Palette.bridgeMid
        )
        addBox(
            to: group,
            size: [4.20, 0.18, 1.16],
            position: [0.05, 2.93, 0.02],
            color: Palette.bridgeTop
        )
        addBox(
            to: group,
            size: [3.88, 0.12, 0.94],
            position: [0.05, 2.48, 0.02],
            color: Palette.bridgeUnder
        )
        addBox(
            to: group,
            size: [4.16, 0.04, 0.12],
            position: [0.05, 3.06, 0.50],
            color: Palette.bridgeLight,
            cornerRadius: 0.01
        )
        addBox(
            to: group,
            size: [4.16, 0.04, 0.12],
            position: [0.05, 3.06, -0.46],
            color: Palette.bridgeLight,
            cornerRadius: 0.01
        )

        addBox(
            to: group,
            size: [1.02, 3.88, 1.02],
            position: [-1.44, 4.43, -0.10],
            color: Palette.baseDark
        )
        addBox(
            to: group,
            size: [1.22, 0.22, 1.22],
            position: [-1.44, 6.21, -0.10],
            color: Palette.towerLight
        )
        addDome(to: group, position: [-1.43, 6.78, -0.08], radius: 0.47)
        addFlag(to: group, position: [-1.23, 7.30, 0.04], scale: 0.94)
        addTrimBands(
            to: group,
            center: [-1.44, 0.0, -0.10],
            size: [0.98, 3.88, 0.98],
            levels: [0.24, 0.46, 0.70]
        )

        addBox(
            to: group,
            size: [1.16, 2.52, 1.16],
            position: [1.26, 3.95, 0.14],
            color: Palette.baseMid
        )
        addBox(
            to: group,
            size: [1.36, 0.20, 1.36],
            position: [1.26, 5.11, 0.14],
            color: Palette.towerLight
        )
        addDome(to: group, position: [1.27, 5.62, 0.12], radius: 0.40)
        addFlag(to: group, position: [1.43, 6.06, 0.30], scale: 0.80)
        addTrimBands(
            to: group,
            center: [1.26, 0.0, 0.14],
            size: [1.12, 2.52, 1.12],
            levels: [0.30, 0.60]
        )

        addBox(
            to: group,
            size: [2.06, 0.22, 0.64],
            position: [0.45, 2.23, 0.96],
            color: Palette.bridgeTop
        )
        addBox(
            to: group,
            size: [2.44, 0.18, 0.58],
            position: [0.54, 2.03, 1.22],
            color: Palette.bridgeMid
        )

        addBox(
            to: group,
            size: [1.90, 0.22, 0.66],
            position: [1.68, 3.22, 0.78],
            color: Palette.bridgeTop
        )
        addBox(
            to: group,
            size: [1.52, 0.06, 0.42],
            position: [1.68, 3.36, 0.82],
            color: UIColor(hex: 0xB04E89)
        )
        addBox(
            to: group,
            size: [1.44, 0.04, 0.12],
            position: [1.68, 3.34, 1.07],
            color: Palette.bridgeLight,
            cornerRadius: 0.01
        )

        addPortal(
            to: group,
            center: [-1.64, 0.0, 0.08],
            span: 0.62,
            columnHeight: 2.42,
            depth: 0.34,
            color: Palette.baseDark
        )
        addPortal(
            to: group,
            center: [-0.58, 0.0, 0.10],
            span: 0.72,
            columnHeight: 2.24,
            depth: 0.34,
            color: Palette.baseDark
        )
        addPortal(
            to: group,
            center: [0.42, 0.0, 0.12],
            span: 0.72,
            columnHeight: 2.26,
            depth: 0.34,
            color: Palette.baseDark
        )
        addPortal(
            to: group,
            center: [1.44, 0.0, 0.16],
            span: 0.64,
            columnHeight: 2.20,
            depth: 0.34,
            color: Palette.baseDark
        )

        addSwitchDisk(to: group, position: [-2.04, 2.95, -0.40], radius: 0.15)

        addAccentPad(to: group, position: [-0.62, 3.03, -0.42], size: [0.18, 0.03, 0.18])
        addAccentPad(to: group, position: [0.40, 3.03, -0.43], size: [0.18, 0.03, 0.18])
        addAccentPad(to: group, position: [0.42, 2.34, 0.97], size: [0.18, 0.03, 0.18])
        addAccentPad(to: group, position: [1.72, 2.43, 0.96], size: [0.18, 0.03, 0.18])
        addPost(to: group, position: [1.05, 2.96, 0.48], height: 0.11)
        addPost(to: group, position: [0.16, 2.10, 1.28], height: 0.11)
        addPost(to: group, position: [2.34, 2.62, 1.03], height: 0.11)

        addPillarRow(
            to: group,
            startX: 0.92,
            count: 6,
            step: 0.36,
            yBase: 0.52,
            z: 1.16,
            height: 0.62,
            width: 0.12,
            depth: 0.12,
            color: Palette.bridgeMid
        )

        addDoor(to: group, position: [-1.44, 4.95, 0.38], size: [0.20, 0.64, 0.05])
        addDoor(to: group, position: [1.27, 4.22, 0.47], size: [0.20, 0.56, 0.05])

        addWindowSlit(to: group, position: [-0.52, 3.14, 0.39], height: 0.22)
        addWindowSlit(to: group, position: [0.34, 3.10, 0.40], height: 0.22)
        addWindowSlit(to: group, position: [1.12, 3.04, 0.44], height: 0.22)
        addWallPatch(to: group, position: [-0.92, 3.28, 0.28], size: [0.11, 0.06, 0.03])
        addWallPatch(to: group, position: [0.03, 3.22, 0.30], size: [0.12, 0.06, 0.03])
        addWallPatch(to: group, position: [0.93, 3.18, 0.32], size: [0.10, 0.05, 0.03])
    }

    private static func buildMidConnections(in parent: Entity) {
        addBox(
            to: parent,
            size: [1.72, 0.24, 0.66],
            position: [-0.24, 1.82, 1.10],
            color: Palette.bridgeTop
        )
        addBox(
            to: parent,
            size: [1.24, 0.18, 0.58],
            position: [0.56, 1.62, 1.18],
            color: Palette.bridgeMid
        )
        addBox(
            to: parent,
            size: [1.60, 0.04, 0.12],
            position: [-0.24, 1.96, 1.36],
            color: Palette.bridgeLight,
            cornerRadius: 0.01
        )
        addBox(
            to: parent,
            size: [1.08, 0.04, 0.10],
            position: [0.56, 1.74, 1.38],
            color: Palette.bridgeLight,
            cornerRadius: 0.01
        )

        addPortal(
            to: parent,
            center: [1.14, 0.0, 1.18],
            span: 0.74,
            columnHeight: 1.76,
            depth: 0.30,
            color: Palette.baseDark
        )

        addBox(
            to: parent,
            size: [1.18, 0.17, 0.24],
            position: [-0.28, 1.42, 1.64],
            color: Palette.bridgeLight
        )
        addOrb(to: parent, position: [-0.66, 1.45, 1.64], radius: 0.05, color: UIColor(hex: 0x893C7B))
        addOrb(to: parent, position: [-0.28, 1.45, 1.64], radius: 0.05, color: UIColor(hex: 0x893C7B))
        addOrb(to: parent, position: [0.10, 1.45, 1.64], radius: 0.05, color: UIColor(hex: 0x893C7B))

        addPillarRow(
            to: parent,
            startX: -0.06,
            count: 3,
            step: 0.32,
            yBase: 0.50,
            z: 1.24,
            height: 0.56,
            width: 0.10,
            depth: 0.10,
            color: Palette.bridgeMid
        )
    }

    private static func addHazeLayers(in parent: Entity) {
        let floor = ModelEntity(
            mesh: .generateBox(size: [14.6, 0.02, 14.6]),
            materials: [UnlitMaterial(color: UIColor(hex: 0x8A63B7, alpha: 0.21))]
        )
        floor.position = [0.0, -0.45, 1.35]
        floor.orientation = simd_quatf(angle: .pi * 0.25, axis: [0, 1, 0])
        parent.addChild(floor)

        let farFloor = ModelEntity(
            mesh: .generateBox(size: [18.5, 0.02, 18.5]),
            materials: [UnlitMaterial(color: UIColor(hex: 0x8C64BC, alpha: 0.10))]
        )
        farFloor.position = [0.0, -0.62, 1.45]
        farFloor.orientation = simd_quatf(angle: .pi * 0.25, axis: [0, 1, 0])
        parent.addChild(farFloor)

        let hazeA = ModelEntity(
            mesh: .generateBox(size: [13.0, 0.02, 10.0]),
            materials: [UnlitMaterial(color: UIColor(hex: 0xC674C8, alpha: 0.22))]
        )
        hazeA.position = [0.0, 0.42, 0.9]
        parent.addChild(hazeA)

        let hazeB = ModelEntity(
            mesh: .generateBox(size: [11.0, 0.02, 8.6]),
            materials: [UnlitMaterial(color: UIColor(hex: 0xA45AAE, alpha: 0.18))]
        )
        hazeB.position = [0.0, 0.05, 0.8]
        parent.addChild(hazeB)
    }

    private static func addAtmosphere(in parent: Entity) {
        for idx in 0..<108 {
            let t = Float(idx)
            let x = remap(fract(sin(t * 12.9898) * 43_758.547), -6.4, 6.4)
            let y = remap(fract(sin(t * 4.221) * 11_173.273), 1.0, 6.8)
            let z = remap(fract(sin(t * 8.731) * 3_347.121), -3.4, 3.2)
            let radius: Float = idx.isMultiple(of: 7) ? 0.029 : 0.013
            let alpha: CGFloat = idx.isMultiple(of: 7) ? 0.30 : 0.16

            let star = ModelEntity(
                mesh: .generateSphere(radius: radius),
                materials: [UnlitMaterial(color: UIColor(white: 1.0, alpha: alpha))]
            )
            star.position = [x, y, z]
            parent.addChild(star)
        }
    }

    @discardableResult
    private static func addBox(
        to parent: Entity,
        size: SIMD3<Float>,
        position: SIMD3<Float>,
        color: UIColor,
        cornerRadius: Float = 0.03
    ) -> ModelEntity {
        let entity = ModelEntity(
            mesh: .generateBox(size: size, cornerRadius: cornerRadius),
            materials: [SimpleMaterial(color: color, roughness: 0.96, isMetallic: false)]
        )
        entity.position = position
        parent.addChild(entity)
        return entity
    }

    private static func addDome(to parent: Entity, position: SIMD3<Float>, radius: Float) {
        addBox(
            to: parent,
            size: [radius * 1.26, radius * 0.28, radius * 1.26],
            position: [position.x, position.y - radius * 0.34, position.z],
            color: Palette.towerLight,
            cornerRadius: radius * 0.12
        )

        let dome = ModelEntity(
            mesh: .generateSphere(radius: radius),
            materials: [SimpleMaterial(color: Palette.dome, roughness: 0.86, isMetallic: false)]
        )
        dome.position = position
        dome.scale = [1.0, 0.76, 1.0]
        parent.addChild(dome)
    }

    private static func addPortal(
        to parent: Entity,
        center: SIMD3<Float>,
        span: Float,
        columnHeight: Float,
        depth: Float,
        color: UIColor
    ) {
        addBox(
            to: parent,
            size: [0.24, columnHeight, depth],
            position: [center.x - span * 0.5, center.y + columnHeight * 0.5, center.z],
            color: color
        )
        addBox(
            to: parent,
            size: [0.24, columnHeight, depth],
            position: [center.x + span * 0.5, center.y + columnHeight * 0.5, center.z],
            color: color
        )
        addBox(
            to: parent,
            size: [span + 0.30, 0.22, depth + 0.05],
            position: [center.x, center.y + columnHeight + 0.11, center.z],
            color: Palette.bridgeUnder
        )
    }

    private static func addRampSteps(
        to parent: Entity,
        origin: SIMD3<Float>,
        count: Int,
        dx: Float,
        dy: Float
    ) {
        for idx in 0..<count {
            let x = origin.x + (Float(idx) * dx)
            let y = origin.y + (Float(idx) * dy)
            addBox(
                to: parent,
                size: [0.20, 0.03, 0.34],
                position: [x, y, origin.z],
                color: Palette.bridgeLight,
                cornerRadius: 0.01
            )
        }
    }

    private static func addCornerStuds(
        to parent: Entity,
        centerX: Float,
        centerZ: Float,
        span: Float,
        y: Float,
        size: Float,
        color: UIColor
    ) {
        let offsets: [SIMD3<Float>] = [
            [centerX - span * 0.5, y, centerZ - span * 0.5],
            [centerX + span * 0.5, y, centerZ - span * 0.5],
            [centerX - span * 0.5, y, centerZ + span * 0.5],
            [centerX + span * 0.5, y, centerZ + span * 0.5]
        ]

        for point in offsets {
            addBox(
                to: parent,
                size: [size, size, size],
                position: point,
                color: color,
                cornerRadius: size * 0.22
            )
        }
    }

    private static func addTrimBands(
        to parent: Entity,
        center: SIMD3<Float>,
        size: SIMD3<Float>,
        levels: [Float]
    ) {
        for level in levels {
            let y = center.y + (size.y * level)
            addBox(
                to: parent,
                size: [size.x * 1.04, 0.045, size.z * 1.04],
                position: [center.x, y, center.z],
                color: UIColor(hex: 0x8B6EDD, alpha: 0.56),
                cornerRadius: 0.01
            )
        }
    }

    private static func addPillarRow(
        to parent: Entity,
        startX: Float,
        count: Int,
        step: Float,
        yBase: Float,
        z: Float,
        height: Float,
        width: Float,
        depth: Float,
        color: UIColor
    ) {
        for idx in 0..<count {
            let x = startX + (Float(idx) * step)
            addBox(
                to: parent,
                size: [width, height, depth],
                position: [x, yBase + (height * 0.5), z],
                color: color,
                cornerRadius: 0.01
            )
        }
    }

    private static func addWallPatch(to parent: Entity, position: SIMD3<Float>, size: SIMD3<Float>) {
        addBox(
            to: parent,
            size: size,
            position: position,
            color: UIColor(hex: 0xA28AE7, alpha: 0.45),
            cornerRadius: 0.01
        )
    }

    private static func addDoor(to parent: Entity, position: SIMD3<Float>, size: SIMD3<Float>) {
        addBox(
            to: parent,
            size: size,
            position: position,
            color: UIColor(hex: 0x442984),
            cornerRadius: 0.02
        )
    }

    private static func addWindowSlit(to parent: Entity, position: SIMD3<Float>, height: Float) {
        addBox(
            to: parent,
            size: [0.08, height, 0.04],
            position: position,
            color: UIColor(hex: 0xC8C7EF, alpha: 0.65),
            cornerRadius: 0.01
        )
    }

    private static func addSwitchDisk(to parent: Entity, position: SIMD3<Float>, radius: Float) {
        let outer = ModelEntity(
            mesh: .generateSphere(radius: radius),
            materials: [SimpleMaterial(color: UIColor(hex: 0xE7D4B1), roughness: 0.95, isMetallic: false)]
        )
        outer.scale = [1, 0.12, 1]
        outer.position = position
        parent.addChild(outer)

        let inner = ModelEntity(
            mesh: .generateSphere(radius: radius * 0.52),
            materials: [SimpleMaterial(color: UIColor(hex: 0x8B6BCF), roughness: 0.88, isMetallic: false)]
        )
        inner.scale = [1, 0.12, 1]
        inner.position = [position.x, position.y + 0.008, position.z]
        parent.addChild(inner)
    }

    private static func addOrb(
        to parent: Entity,
        position: SIMD3<Float>,
        radius: Float,
        color: UIColor
    ) {
        let orb = ModelEntity(
            mesh: .generateSphere(radius: radius),
            materials: [SimpleMaterial(color: color, roughness: 0.9, isMetallic: false)]
        )
        orb.scale = [1, 0.4, 1]
        orb.position = position
        parent.addChild(orb)
    }

    private static func addFlag(to parent: Entity, position: SIMD3<Float>, scale: Float) {
        addBox(
            to: parent,
            size: [0.05 * scale, 0.74 * scale, 0.05 * scale],
            position: [position.x, position.y - (0.37 * scale), position.z],
            color: UIColor(hex: 0xCCACE3),
            cornerRadius: 0.012 * scale
        )

        let flagGroup = Entity()
        flagGroup.position = [position.x + (0.12 * scale), position.y - (0.05 * scale), position.z]
        parent.addChild(flagGroup)

        let segments: [(SIMD3<Float>, SIMD3<Float>)] = [
            ([0.16, 0.00, 0.00], [0.34, 0.02, 0.12]),
            ([0.36, 0.04, 0.01], [0.31, 0.02, 0.11]),
            ([0.56, -0.02, 0.03], [0.25, 0.02, 0.10])
        ]

        for segment in segments {
            addBox(
                to: flagGroup,
                size: segment.1 * scale,
                position: segment.0 * scale,
                color: UIColor(hex: 0x5E2E9C),
                cornerRadius: 0.012 * scale
            )
        }
    }

    private static func addPost(to parent: Entity, position: SIMD3<Float>, height: Float) {
        addBox(
            to: parent,
            size: [0.04, height, 0.04],
            position: [position.x, position.y + (height * 0.5), position.z],
            color: UIColor(hex: 0xF4E8FC, alpha: 0.90),
            cornerRadius: 0.01
        )
    }

    private static func addAccentPad(
        to parent: Entity,
        position: SIMD3<Float>,
        size: SIMD3<Float>
    ) {
        addBox(
            to: parent,
            size: size,
            position: position,
            color: UIColor(hex: 0xFF6CAF),
            cornerRadius: 0.01
        )
        addBox(
            to: parent,
            size: size * SIMD3<Float>(repeating: 0.52),
            position: [position.x, position.y + 0.011, position.z],
            color: UIColor(hex: 0xFFD6EC),
            cornerRadius: 0.006
        )
    }

    private static func addTraveler(
        to parent: Entity,
        position: SIMD3<Float>,
        bodyColor: UIColor,
        capeColor: UIColor
    ) {
        let traveler = Entity()
        traveler.position = position
        parent.addChild(traveler)

        let body = ModelEntity(
            mesh: .generateBox(size: [0.09, 0.18, 0.09], cornerRadius: 0.02),
            materials: [SimpleMaterial(color: bodyColor, roughness: 0.75, isMetallic: false)]
        )
        body.position = [0, 0.09, 0]
        traveler.addChild(body)

        let head = ModelEntity(
            mesh: .generateSphere(radius: 0.031),
            materials: [SimpleMaterial(color: UIColor(hex: 0xFBEBD2), roughness: 1.0, isMetallic: false)]
        )
        head.position = [0.0, 0.21, 0.01]
        traveler.addChild(head)

        let cape = addBox(
            to: traveler,
            size: [0.05, 0.12, 0.02],
            position: [0.045, 0.11, -0.01],
            color: capeColor,
            cornerRadius: 0.008
        )
        cape.orientation = simd_quatf(angle: -0.31, axis: [1, 0, 0])
    }

    private static func fract(_ value: Float) -> Float {
        value - floor(value)
    }

    private static func remap(_ t: Float, _ min: Float, _ max: Float) -> Float {
        min + ((max - min) * t)
    }
}

private enum Palette {
    static let baseDark = UIColor(hex: 0x4C2F9E)
    static let baseMid = UIColor(hex: 0x5E3DAE)
    static let baseLight = UIColor(hex: 0x6D4EC1)
    static let towerMid = UIColor(hex: 0x7050C4)
    static let towerLight = UIColor(hex: 0x8661D2)
    static let bridgeUnder = UIColor(hex: 0x5535A7)
    static let bridgeMid = UIColor(hex: 0x6444B7)
    static let bridgeTop = UIColor(hex: 0x7355C8)
    static let bridgeLight = UIColor(hex: 0x8868D7)
    static let dome = UIColor(hex: 0xA640A9)
}

private extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1) {
        self.init(
            red: CGFloat((hex >> 16) & 0xFF) / 255.0,
            green: CGFloat((hex >> 8) & 0xFF) / 255.0,
            blue: CGFloat(hex & 0xFF) / 255.0,
            alpha: alpha
        )
    }
}
