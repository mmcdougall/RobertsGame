# RobertsGame Scene Prototype

This workspace contains a ready-to-run Xcode iOS app project (`RobertsGame.xcodeproj`) using SwiftUI + RealityKit to recreate the attached screenshot style:

- pink/purple atmospheric gradient background
- large sun disk behind the right tower
- floating stylized architecture with domes, arches, bridges, and accent pads
- custom non-AR camera angle and tuned lighting

## Files

- `RobertsGameApp.swift` app entry point
- `ContentView.swift` SwiftUI composition (background + overlays)
- `MonumentRealityView.swift` RealityKit host view
- `MonumentSceneBuilder.swift` procedural 3D scene builder

## Run in Xcode

1. Open `/Users/mikey/Data/Sources/RobertsGame/RobertsGame.xcodeproj`.
2. Select the `RobertsGame` scheme.
3. Pick an iPhone simulator (iOS 17+).
4. Press `Cmd+R`.

## CLI build check used

```bash
cd /Users/mikey/Data/Sources/RobertsGame
xcodebuild -project RobertsGame.xcodeproj -scheme RobertsGame -configuration Debug -destination 'generic/platform=iOS Simulator' -derivedDataPath /tmp/RobertsGameDerived CODE_SIGNING_ALLOWED=NO build
```

## Notes

- The scene is intentionally stylized to match the screenshot mood and composition.
- Use `MonumentSceneBuilder` constants for easy palette/layout tuning.
