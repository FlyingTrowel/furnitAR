package com.example.furnitar

import android.os.Bundle
import android.widget.Button
import android.widget.FrameLayout
import android.view.Gravity
import io.github.sceneview.ar.ARSceneView
import androidx.activity.ComponentActivity  // Add this import
import androidx.lifecycle.*
import io.github.sceneview.ar.scene.PlaneRenderer
import com.google.android.filament.Engine


class ARRenderer : ComponentActivity() {  // Change to ComponentActivity

    lateinit var sceneView: ARSceneView
    lateinit var planeRenderer: PlaneRenderer


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val engine = Engine.create()

        // Create our layout container
        val frameLayout = FrameLayout(this)

        // Create and setup the AR Scene View (this handles the camera)
        sceneView = ARSceneView(
            context = this,
            sharedLifecycle = lifecycle,
        )

        // Add the scene view to our layout
        frameLayout.addView(sceneView)

        // Add a close button
        val closeButton = Button(this).apply {
            text = "Close"
            setOnClickListener {
                finish()
            }
        }

        // Put the button at the bottom of the screen
        val buttonParams = FrameLayout.LayoutParams(
            FrameLayout.LayoutParams.WRAP_CONTENT,
            FrameLayout.LayoutParams.WRAP_CONTENT
        ).apply {
            gravity = Gravity.BOTTOM or Gravity.CENTER_HORIZONTAL
            bottomMargin = 50
        }

        frameLayout.addView(closeButton, buttonParams)

        // Set our layout as the content view
        setContentView(frameLayout)

    }

    override fun onDestroy() {
        super.onDestroy()
        sceneView.destroy()
    }
}