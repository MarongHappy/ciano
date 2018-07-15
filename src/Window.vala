/*
* Copyright (c) 2017 Robert San <robertsanseries@gmail.com>
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*/

using Ciano.Utils;
using Ciano.Widgets;
using Ciano.Facades;

namespace Ciano {

    /**
     * Class responsible for creating the u window and will contain contain other widgets. 
     * allowing the user to manipulate the window (resize it, move it, close it, ...).
     *
     * @see Gtk.ApplicationWindow
     * @since 0.1.0
     */
    public class Window : Gtk.ApplicationWindow {
         
        /**
         * Constructs a new {@code Window} object.
         *
         * @see Ciano.Configs.Constants
         * @see style_provider
         * @see build
         */
        public Window (Gtk.Application app) {
            Object (
                // The Application associated with the window.
                application: app,

                // If the window should be resizable.
                resizable: true
            );

            // Windows should be placed in the center of the screen.
            this.window_position = Gtk.WindowPosition.CENTER;

            // Sets the default size of a window.
            this.set_default_size (500, 400);

            // Sets the minimum size of a widget; that is, the widget’s size 
            // request will be at least width by height.
            this.set_size_request (500, 400);

            // Background-Color
            this.get_style_context ().add_class ("window-background-color");
       
            // Load position and window size in the last application session.
            this.load_window_position_size ();
            
            // Load the application's CSS.
            this.style_provider ();

            //
            this.build (app);
        }

         /**
         * Load position and window size in the last application session.
         * 
         * @return {@code void}
         * @see Ciano.Services.Settings
         * @since v0.2.0
         */
        private void load_window_position_size () {
            Ciano.Services.Settings settings = Ciano.Services.Settings.get_instance ();
            int x = settings.window_x;
            int y = settings.window_y;
            int h = settings.window_height;
            int w = settings.window_width;

            if (x != -1 && y != -1) {
                this.move (x, y);
            }

            if (w != 0 && h != 0) {
                this.resize (w, h);
            }
        }

        /**
         * Load the application's CSS.
         *
         * @return {@code void}
         * @see Ciano.Configs.Constants
         */
        private void style_provider () {
            Gtk.CssProvider css_provider = new Gtk.CssProvider ();
            css_provider.load_from_resource ("com/github/robertsanseries/ciano/css/stylesheet.css");
            
            Gtk.StyleContext.add_provider_for_screen (
                Gdk.Screen.get_default (), css_provider,
                Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
            );
        }

        /**
         * Method is triggered when the user closes the main window, saving the size and position
         * of the window in the current state.
         *
         * @param {@code Gdk.EventAny} event
         * @return {@code bool}
         * @see Ciano.Services.Settings
         * @since v0.2.0
         */
        public override bool delete_event (Gdk.EventAny event) {
            int x, y, w, h;
            this.get_position (out x, out y);
            this.get_size (out w, out h);

            Ciano.Services.Settings settings = Ciano.Services.Settings.get_instance ();
            settings.window_x = x;
            settings.window_y = y;
            settings.window_width = w;
            settings.window_height = h;

            return false;
        }

        /*
         * Load classes for application building.
         *
         * @see Ciano.Views.WelcomeView
         * @return {@code void}
         */
        private void build (Gtk.Application app) {
            Widgets.HeaderBar headerbar = new Widgets.HeaderBar ();
            
            headerbar.icon_settings_clicked.connect (() => { 
                DialogFacade.open_dialog_preferences (this);
            });

            headerbar.icon_report_problem_clicked.connect (() => { 
                CoreUtil.launch_uri ("https://github.com/robertsanseries/ciano/issues");
            });           

            headerbar.icon_about_clicked.connect (() => { 
                DialogFacade.open_dialog_about (this);
            });
           
            headerbar.set_visible_icons(false);

            Widgets.Welcome welcome = new Widgets.Welcome ();
            welcome.activated.connect ((index) => {
                switch (index) {
                    case 0:
                        
                        break;
                    case 1:
                        DialogFacade.open_dialog_informations (this);
                        break;
                 }
            });

            Gtk.Stack stack = new Gtk.Stack ();
            stack.transition_type = Gtk.StackTransitionType.SLIDE_LEFT_RIGHT;
            stack.get_style_context ().add_class (Gtk.STYLE_CLASS_VIEW);
            stack.add_named (welcome, "WELCOME_ID");

            this.set_titlebar (headerbar);
            this.add (stack);
            this.show_all ();
        }
    }
}