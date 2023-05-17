package com.castlib.castlib

import com.castlib.castlib.ExpandedControlsActivity
import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import androidx.annotation.NonNull
import androidx.mediarouter.app.MediaRouteChooserDialog
import com.google.android.gms.cast.framework.CastContext

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

import com.google.android.gms.cast.MediaInfo
import com.google.android.gms.cast.MediaMetadata
import com.google.android.gms.cast.MediaTrack
import com.google.android.gms.cast.framework.CastSession
import com.google.android.gms.cast.framework.SessionManager
import com.google.android.gms.common.images.WebImage
import kotlin.math.roundToLong

/** CastlibPlugin */
class CastlibPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private lateinit var activity: Activity

    private var mCastSession: CastSession? = null
    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "castlib")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "show_connection_dialog") {
            mCastSession = CastContext.getSharedInstance(activity).sessionManager.currentCastSession;
            var tChooserDialog = MediaRouteChooserDialog(activity, R.style.Theme_AppCompat_Dialog)
            tChooserDialog.routeSelector = CastContext.getSharedInstance(activity).mergedSelector!!
            tChooserDialog.show()
            result.success(true)
        } else if (call.method == "is_connected") {
            var hasConnection = false;
            if (mCastSession != null) {
                hasConnection = true
            }
            result.success(hasConnection)
        } else if (call.method == "show_control_dialog") {
            mCastSession = CastContext.getSharedInstance(activity).sessionManager.currentCastSession;
            var remoteMediaClient = mCastSession!!.getRemoteMediaClient()
            val intent = Intent(activity, ExpandedControlsActivity::class.java)
            activity.startActivity(intent)
            result.success(true)
        } else if (call.method == "start_casting") {
            mCastSession = CastContext.getSharedInstance(activity).sessionManager.currentCastSession;
            mCastSession!!.remoteMediaClient!!.stop()
            var subtitleUrl:String? = call.argument("subtitle")
            var arabicSubtitle:MediaTrack
            var tracks = ArrayList<MediaTrack>()

            if( subtitleUrl != null){
                arabicSubtitle = MediaTrack.Builder(1,
                    MediaTrack.TYPE_TEXT)
                    .setName("Arabic Subtitle")
                    .setSubtype(MediaTrack.SUBTYPE_SUBTITLES)
                    .setContentId(subtitleUrl)
                    .setLanguage("ar")
                    .build()
                tracks.add(arabicSubtitle)
            }

            val movieMetadata = MediaMetadata(MediaMetadata.MEDIA_TYPE_MOVIE)
            movieMetadata.putString(MediaMetadata.KEY_TITLE, call.argument("title")!!)
            movieMetadata.putString(MediaMetadata.KEY_SUBTITLE, call.argument("description")!!)
            movieMetadata.addImage(WebImage(Uri.parse(call.argument("posterPhoto"))))
            val mediaInfo = MediaInfo.Builder(call.argument("mediaUrl")!!)
                .setStreamType(MediaInfo.STREAM_TYPE_NONE)
                .setContentType("hls")
                .setMetadata(movieMetadata)
                .setMediaTracks(tracks)
                .build()
            val tracksArray: LongArray = longArrayOf(1)
            val remoteMediaClient = mCastSession!!.getRemoteMediaClient()
            val playPosition = call.argument<String>("playPosition")!!.toDouble()
            remoteMediaClient!!.setActiveMediaTracks(tracksArray)
            remoteMediaClient!!.load(mediaInfo, false, playPosition!!.roundToLong())
            remoteMediaClient!!.seek(playPosition!!.roundToLong())
            val intent = Intent(activity, ExpandedControlsActivity::class.java)
            activity.startActivity(intent)
            result.success(true)
        } else if(call.method == "stop_casting"){
            mCastSession = CastContext.getSharedInstance(activity).sessionManager.currentCastSession;
            mCastSession!!.remoteMediaClient!!.stop()
            result.success(true)
        }
        else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        TODO("Not yet implemented")
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        TODO("Not yet implemented")
    }
}
