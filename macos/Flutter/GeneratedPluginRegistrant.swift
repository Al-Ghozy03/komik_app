//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import leak_detector
import path_provider_macos
import sqflite

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  LeakDetectorPlugin.register(with: registry.registrar(forPlugin: "LeakDetectorPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  SqflitePlugin.register(with: registry.registrar(forPlugin: "SqflitePlugin"))
}
