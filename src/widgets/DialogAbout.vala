/*
 * Copyright (c) 2017-2018 Robert San <robertsanseries@gmail.com>
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

using Alvane.Utils;
using Ciano.Views;

namespace Ciano.Widgets {

    public class DialogAbout : Gtk.Dialog {

        public signal void button_translate_clicked ();
        public signal void button_bug_clicked ();
        public signal void button_help_clicked ();

        public DialogAbout (ApplicationView parent) {
            this.title= _("About");
            this.border_width= 5;
            this.deletable= false;
            this.resizable= false;
            this.set_default_size (500, 350);
            this.set_size_request (500, 350);
            this.set_transient_for (parent);
            this.set_modal (true);

            string[] authors = {
                "Robert San <https://github.com/robertsanseries>"
            };
            
            string[] contributors = {
                "Aljelly <https://github.com/aljelly>",
                "Lains <https://github.com/lainsce>", 
                "Maccer1 <https://github.com/Maccer1>"
            };

            string[] translators = {
                "Heimen Stoffels <https://github.com/Vistaus>",
                "Maccer1 <https://github.com/Maccer1>", 
                "Nvivant <https://github.com/nvivant>", 
                "Welaq <https://github.com/welaq>"
            };

            Gtk.Image logo_image = new Gtk.Image ();
            logo_image.icon_name = "com.github.robertsanseries.ciano";
            logo_image.pixel_size = 128;

            Gtk.Label name_label = new Gtk.Label ("Ciano 0.2.0");
            name_label.get_style_context ().add_class (Granite.STYLE_CLASS_H2_LABEL);
            name_label.xalign= 0;

            Gtk.Label description_label = new Gtk.Label (_("A multimedia file converter focused on simplicity."));
            description_label.wrap= true;
            description_label.xalign= 0;
            description_label.halign = Gtk.Align.START;
            description_label.valign = Gtk.Align.START;
            description_label.set_line_wrap (true);
            description_label.set_line_wrap_mode (Pango.WrapMode.WORD);
            description_label.get_style_context ().add_class (Gtk.STYLE_CLASS_DIM_LABEL);

            Gtk.Label website_label = new Gtk.Label (StringUtil.EMPTY);
            website_label.set_markup ("<span><a href=\"https://robertsanseries.github.io/ciano\" title=\"https://robertsanseries.github.io/ciano\">"+_("Website")+"</a></span>\n");
            website_label.wrap= true;
            website_label.xalign= 0;

            Gtk.Label authors_label = new Gtk.Label (StringUtil.EMPTY);
            authors_label.set_markup(organize_block_markup("<span size=\"small\">"+_("Authors:")+"</span>\n", authors));
            authors_label.wrap= true;
            authors_label.xalign= 0;

            Gtk.Label contributors_label = new Gtk.Label (StringUtil.EMPTY);
            contributors_label.set_markup(organize_block_markup("<span size=\"small\">"+_("Contributors:")+"</span>\n", contributors));
            contributors_label.wrap= true;
            contributors_label.xalign= 0;

            Gtk.Label translators_label = new Gtk.Label (StringUtil.EMPTY);
            translators_label.set_markup(organize_block_markup("<span size=\"small\">"+_("Translators:")+"</span>\n", translators));
            translators_label.wrap= true;
            translators_label.xalign= 0;

            Gtk.Label copyright_label = new Gtk.Label (_("Copyright © 2017-2018 Robert San\n"));
            copyright_label.wrap= true;
            copyright_label.xalign= 0;
            copyright_label.selectable= true;

            Gtk.Label license_label = new Gtk.Label (StringUtil.EMPTY);
            license_label.set_markup("<span size=\"small\">" + _("This program is published under the terms of the GPL license, it comes with ABSOLUTELY NO WARRANTY; for details, visit <a href=\"http://www.gnu.org/licenses/gpl.html\">http://www.gnu.org/licenses/gpl.html</a></span>\n"));
            license_label.wrap= true;
            license_label.xalign= 0;
            license_label.max_width_chars= 48;

            Gtk.Grid content_scrolled_grid = new Gtk.Grid ();
            content_scrolled_grid.orientation = Gtk.Orientation.VERTICAL;
            content_scrolled_grid.add (copyright_label);
            content_scrolled_grid.add (license_label);
            content_scrolled_grid.add (website_label);
            content_scrolled_grid.add (authors_label);
            content_scrolled_grid.add (contributors_label);
            content_scrolled_grid.add (translators_label);

            Gtk.ScrolledWindow content_scrolled = new Gtk.ScrolledWindow (null, null);
            content_scrolled.hscrollbar_policy = Gtk.PolicyType.NEVER;
            content_scrolled.vexpand = true;
            content_scrolled.width_request = 330;           
            content_scrolled.add (content_scrolled_grid);

            Gtk.Box box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            box.pack_start (name_label, false, false, 0);
            box.pack_start (description_label, false, false, 0);

            Gtk.Grid grid = new Gtk.Grid ();
            grid.column_spacing = 12;
            grid.row_spacing = 12;
            grid.height_request = 136;
            grid.margin = 12;
            grid.attach (logo_image, 0, 0, 1, 2);
            grid.attach (box, 1, 0, 12, 1);
            grid.attach (content_scrolled, 1, 1, 12, 1);

            Gtk.Box content_area = (Gtk.Box) this.get_content_area ();
            content_area.add (grid);

            var help_button = new Gtk.Button.with_label (" ? ");
            help_button.halign = Gtk.Align.CENTER;
            help_button.get_style_context ().add_class ("circular");
            help_button.clicked.connect (() => { button_help_clicked (); });

            Gtk.Button translate_button = new Gtk.Button.with_label (_("Suggest Translations"));
            translate_button.clicked.connect (() => { button_translate_clicked (); });

            Gtk.Button bug_button = new Gtk.Button.with_label (_("Report a Problem"));
            bug_button.clicked.connect (() => { button_bug_clicked (); });

            var action_area = (Gtk.Box) this.get_action_area ();
            action_area.pack_end (help_button, false, false, 0);
            action_area.pack_start (bug_button, false, false, 0);
            action_area.pack_start (translate_button, false, false, 0);
            action_area.reorder_child (bug_button, 0);
            action_area.reorder_child (translate_button, 0);

            ((Gtk.ButtonBox) action_area).set_child_secondary (help_button, true);
            ((Gtk.ButtonBox) action_area).set_child_non_homogeneous (help_button, true);

            Gtk.Button close_button = (Gtk.Button) this.add_button (_("Close"), Gtk.ResponseType.CANCEL);
            close_button.clicked.connect (() => { this.destroy (); });

            this.show_all ();
            content_scrolled.get_vadjustment ().set_value (0);
        }

        private string organize_block_markup (string title, string[] peoples) {
            string text  = StringUtil.EMPTY;
            string name  = StringUtil.EMPTY;
            string profile_url = StringUtil.EMPTY;
            string _person_data;
            bool profile_url_started = false;

            text += title + "<span size=\"small\">";

            for (int i= 0;i<peoples.length;i++) {
                if (peoples[i] == null)
                    break;
                
                _person_data = peoples[i];

                for (int j=0;j< _person_data.length;j++){

                    if ( _person_data.get (j) == '<')
                        profile_url_started = true;

                    if (!profile_url_started)
                        name += _person_data[j].to_string ();

                    else
                        if (_person_data.get (j) != '>' && _person_data.get (j) != '<')
                            profile_url +=_person_data[j].to_string ();

                }

                if (profile_url == StringUtil.EMPTY)
                    text += "<u>%s</u>\n".printf (name.strip ());
                else
                    text += "<a href=\"%s\" title=\"%s\">%s</a>\n".printf (profile_url, profile_url, name.strip ());

                profile_url = StringUtil.EMPTY;
                name = StringUtil.EMPTY;
                profile_url_started = false;
            }

            text += "</span>";

            return text;
        }
    }
}

