import SwiftUI
import RealityKit
import UIKit

struct MonumentRealityView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIView(context: Context) -> ARView {
        let view = ARView(frame: .zero, cameraMode: .nonAR, automaticallyConfigureSession: false)
        view.backgroundColor = .clear
        view.environment.background = .color(.clear)
        view.renderOptions = [
            .disableAREnvironmentLighting,
            .disablePersonOcclusion,
            .disableDepthOfField,
            .disableMotionBlur,
            .disableGroundingShadows,
            .disableFaceMesh,
            .disableCameraGrain
        ]
        view.environment.sceneUnderstanding.options = []

        let worldAnchor = AnchorEntity(world: .zero)
        MonumentSceneBuilder.build(into: worldAnchor)
        view.scene.addAnchor(worldAnchor)

        let lightAnchor = AnchorEntity(world: .zero)
        MonumentSceneBuilder.addLights(into: lightAnchor)
        view.scene.addAnchor(lightAnchor)

        let cameraAnchor = AnchorEntity(world: .zero)
        let camera = PerspectiveCamera()
        cameraAnchor.addChild(camera)
        view.scene.addAnchor(cameraAnchor)
        context.coordinator.attach(camera: camera, to: view)
        context.coordinator.configureGestures(on: view)
        context.coordinator.updateCamera(for: view.bounds.size)

        return view
    }

    func updateUIView(_ uiView: ARView, context: Context) {
        context.coordinator.updateCamera(for: uiView.bounds.size)
    }

    final class Coordinator: NSObject {
        private weak var arView: ARView?
        private weak var camera: PerspectiveCamera?

        private var target = SIMD3<Float>(0.05, 2.15, 0.35)
        private var yaw: Float = 0.02
        private var pitch: Float = 0.23
        private var distance: Float = 12.0
        private var didSetInitialFit = false
        private var lastIsPortrait: Bool?

        private let minDistance: Float = 10.0
        private let maxDistance: Float = 22.0

        func attach(camera: PerspectiveCamera, to view: ARView) {
            self.camera = camera
            self.arView = view
        }

        func configureGestures(on view: ARView) {
            let orbitPan = UIPanGestureRecognizer(target: self, action: #selector(handleOrbitPan(_:)))
            orbitPan.minimumNumberOfTouches = 1
            orbitPan.maximumNumberOfTouches = 1
            view.addGestureRecognizer(orbitPan)

            let scenePan = UIPanGestureRecognizer(target: self, action: #selector(handleScenePan(_:)))
            scenePan.minimumNumberOfTouches = 2
            scenePan.maximumNumberOfTouches = 2
            view.addGestureRecognizer(scenePan)

            let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
            view.addGestureRecognizer(pinch)
        }

        func updateCamera(for size: CGSize) {
            guard let camera, size.width > 0, size.height > 0 else { return }

            let isPortrait = size.height > size.width
            if !didSetInitialFit || lastIsPortrait != isPortrait {
                target = [0.05, 2.15, 0.35]
                yaw = 0.02
                pitch = isPortrait ? 0.23 : 0.22
                distance = isPortrait ? 16.0 : 12.8
                camera.camera.fieldOfViewInDegrees = isPortrait ? 40 : 31

                didSetInitialFit = true
                lastIsPortrait = isPortrait
            }

            applyCamera()
        }

        @objc
        private func handleOrbitPan(_ gesture: UIPanGestureRecognizer) {
            let delta = gesture.translation(in: gesture.view)
            gesture.setTranslation(.zero, in: gesture.view)

            let sensitivity: Float = 0.0042
            yaw -= Float(delta.x) * sensitivity
            pitch += Float(delta.y) * sensitivity
            pitch = max(0.08, min(0.55, pitch))

            applyCamera()
        }

        @objc
        private func handleScenePan(_ gesture: UIPanGestureRecognizer) {
            let delta = gesture.translation(in: gesture.view)
            gesture.setTranslation(.zero, in: gesture.view)

            // Move the focal target in screen-space: content follows finger drag.
            let worldPerPoint = distance * 0.0028
            let right = SIMD3<Float>(cos(yaw), 0, -sin(yaw))
            let up = SIMD3<Float>(0, 1, 0)

            target -= right * Float(delta.x) * worldPerPoint
            target += up * Float(delta.y) * worldPerPoint

            target.x = max(-5.2, min(5.2, target.x))
            target.y = max(0.3, min(5.5, target.y))
            target.z = max(-3.2, min(4.2, target.z))

            applyCamera()
        }

        @objc
        private func handlePinch(_ gesture: UIPinchGestureRecognizer) {
            let scale = max(0.5, min(2.0, Float(gesture.scale)))
            distance /= scale
            distance = max(minDistance, min(maxDistance, distance))
            gesture.scale = 1.0

            applyCamera()
        }

        private func applyCamera() {
            guard let camera else { return }

            let cosPitch = cos(pitch)
            let position = SIMD3<Float>(
                target.x + distance * cosPitch * sin(yaw),
                target.y + distance * sin(pitch),
                target.z + distance * cosPitch * cos(yaw)
            )

            camera.position = position
            camera.look(at: target, from: position, relativeTo: nil)
        }
    }
}
