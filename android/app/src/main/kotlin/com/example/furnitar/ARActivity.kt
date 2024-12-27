package com.example.furnitar

import android.Manifest
import android.app.Activity
import android.content.pm.PackageManager
import android.opengl.GLSurfaceView
import android.os.Bundle
import android.view.Gravity
import android.widget.Button
import android.widget.FrameLayout
import android.widget.Toast
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.google.ar.core.*
import com.google.ar.core.ArCoreApk.*
import javax.microedition.khronos.egl.EGLConfig
import javax.microedition.khronos.opengles.GL10
import android.opengl.GLES20

class ARActivity : Activity() {

    private val CAMERA_PERMISSION_CODE = 1
    private var surfaceView: GLSurfaceView? = null  // Make nullable
    private var session: Session? = null  // Make nullable

    private val renderer = object : GLSurfaceView.Renderer {
        override fun onSurfaceCreated(gl: GL10?, config: EGLConfig?) {
            GLES20.glClearColor(0.0f, 0.0f, 0.0f, 1.0f)
        }

        override fun onSurfaceChanged(gl: GL10?, width: Int, height: Int) {
            GLES20.glViewport(0, 0, width, height)
        }

        override fun onDrawFrame(gl: GL10?) {
            GLES20.glClear(GLES20.GL_COLOR_BUFFER_BIT or GLES20.GL_DEPTH_BUFFER_BIT)

            session?.let { activeSession ->  // Safe call using session
                try {
                    activeSession.setCameraTextureName(0)
                    val frame = activeSession.update()
                } catch (e: Exception) {
                    println("Failed to get camera frame: ${e.message}")
                }
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Check if camera permission is granted
        if (!hasCameraPermission()) {
            requestCameraPermission()
            return  // Exit early
        }

        // Check if AR Core is available
        if (!isARCoreSupportedAndUpToDate()) {
            Toast.makeText(
                    this,
                    "Google Play Service for AR Required",
                    Toast.LENGTH_LONG
            ).show()
            finish()
            return  // Exit early
        }

        // Initialize AR Session
        try {
            session = Session(this)
            val config = Config(session)
            print(config)
            session?.configure(config)
        } catch (e: Exception) {
            println("Failed to create AR session: ${e.message}")
            finish()
            return  // Exit early
        }

        // Create GLSurfaceView for camera preview
        surfaceView = GLSurfaceView(this).apply {
            setEGLContextClientVersion(2)
            preserveEGLContextOnPause = true
            setRenderer(renderer)
            renderMode = GLSurfaceView.RENDERMODE_CONTINUOUSLY
        }

        // Create the layout
        val frameLayout = FrameLayout(this)

        // Add the GLSurfaceView
        surfaceView?.let { view ->  // Safe call using surfaceView
            frameLayout.addView(view)
        }

        // Create and add the button
        val closeButton = Button(this).apply {
            text = "Back to Flutter"
            setOnClickListener {
                session?.close()  // Safe call using session
                finish()
            }
        }

        val params = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.WRAP_CONTENT,
                FrameLayout.LayoutParams.WRAP_CONTENT
        ).apply {
            gravity = Gravity.BOTTOM or Gravity.CENTER_HORIZONTAL
            bottomMargin = 50
        }
        frameLayout.addView(closeButton, params)

        setContentView(frameLayout)
    }

    override fun onResume() {
        super.onResume()
        try {
            session?.resume()  // Safe call using session
            surfaceView?.onResume()  // Safe call using surfaceView
        } catch (e: Exception) {
            println("Failed to resume AR session: ${e.message}")
        }
    }

    override fun onPause() {
        super.onPause()
        try {
            surfaceView?.onPause()  // Safe call using surfaceView
            session?.pause()  // Safe call using session
        } catch (e: Exception) {
            println("Failed to pause AR session: ${e.message}")
        }
    }

    // Your existing permission methods remain the same
    private fun hasCameraPermission(): Boolean {
        return ContextCompat.checkSelfPermission(
                this,
                Manifest.permission.CAMERA
        ) == PackageManager.PERMISSION_GRANTED
    }

    private fun requestCameraPermission() {
        ActivityCompat.requestPermissions(
                this,
                arrayOf(Manifest.permission.CAMERA),
                CAMERA_PERMISSION_CODE
        )
    }

    private fun isARCoreSupportedAndUpToDate(): Boolean {
        val availability: Availability = ArCoreApk.getInstance().checkAvailability(this)
        return when (availability) {
            Availability.SUPPORTED_INSTALLED -> true
            else -> false
        }
    }
}