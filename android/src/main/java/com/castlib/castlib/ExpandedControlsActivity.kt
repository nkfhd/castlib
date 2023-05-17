package com.castlib.castlib

import com.google.android.gms.cast.framework.media.widget.ExpandedControllerActivity

import android.view.Menu
import com.castlib.castlib.R
import com.google.android.gms.cast.framework.CastButtonFactory


/**
 * An example of extending [ExpandedControllerActivity] to add a cast button.
 */
class ExpandedControlsActivity : ExpandedControllerActivity() {
    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        super.onCreateOptionsMenu(menu)
        menuInflater.inflate(R.menu.expanded_controller_menu, menu)
        CastButtonFactory.setUpMediaRouteButton(this, menu, R.id.media_route_cast_menu_item)
        return true
    }
}