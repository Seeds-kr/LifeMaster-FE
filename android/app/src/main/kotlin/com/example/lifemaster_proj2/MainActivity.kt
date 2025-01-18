package com.example.lifemaster_proj2

import android.os.Bundle
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Flutter와 Kotlin 간의 통신을 위한 MethodChannel 설정
        MethodChannel(flutterEngine.dartExecutor, "com.example.lifemaster_proj2/native")
            .setMethodCallHandler { call, result ->
                if (call.method == "showNativeUI") {
                    // 네이티브 UI를 실행하는 함수 호출
                    showNativeUI()
                    result.success("Native UI shown") // 성공적으로 네이티브 UI가 실행되었음을 Flutter로 전달
                } else {
                    result.notImplemented() // 메서드가 구현되지 않은 경우
                }
            }
    }

    // 네이티브 UI 실행 함수
    private fun showNativeUI() {
        // 예시로 Toast 메시지 표시
        Toast.makeText(this, "Native UI 실행됨", Toast.LENGTH_SHORT).show()

        // 여기서 실제 UI를 추가하거나 변경할 수 있음
    }
}

