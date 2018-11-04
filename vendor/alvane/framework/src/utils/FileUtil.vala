/*
 * MIT License
 *
 * Copyright (c) 2018 Alvane Framework
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

namespace Alvane.Utils {
	/**
     * The {@code FileUtil} class related to files handling.
     *
     * @since 0.1.0
     */
    public class FileUtil {

		/**
	     * Open folder in app files.
	     *
	     * Exemple:
	     * > FileUtil.open_folder_files(uris)
	     * 
	     * @param {@code string} - uris
	     */
		public static void open_folder_file_app (string[] uris) {
	        string cmd = "pantheon-files -t";

	        foreach (string s in uris) {
	            cmd += (StringUtil.SPACE + s);
	        }

	        try {
	            Process.spawn_command_line_async (cmd);
	        } catch (Error e) {
	            critical ("Unable to open item or folder with command %s. %s".printf (cmd, e.message));
	        }
	    }

	    /**
	     * Create file and write.
	     *
	     * Exemple:
	     * > FileUtil.create_file("/etc", "ola.text", array.data);
	     * 
	     * @param {@code string} - dir
	     * @param {@code string} - name_file
	     * @param {@code GenericArray<string> > data} - words
	     */
	    public static void create_file (string dir, string name_file, string[] words) {
	    	try {
			    var directory = File.new_for_path (dir);
			    
			    if (!directory.query_exists ()) {
			    	// Create directory and parent directories if none exist
			    	directory.make_directory_with_parents();
			    } 

		    	var file = File.new_for_path (dir + "/" + name_file);
		    	var text = StringUtil.EMPTY;

			    foreach (string word in words) {
	            	text += (StringUtil.SPACE + word);
	        	}

	        	if (!file.query_exists ()) {	
	        		var file_stream = file.create (FileCreateFlags.NONE);
	        		var data_stream = new DataOutputStream (file_stream);
		        	data_stream.put_string (text);
		        }

	        } catch (Error e) {
	            critical (e.message);
	        }
	    }

	    /**
	     * Delete file.
	     *
	     * Exemple:
	     * > FileUtil.delete_file("/etc", "ola.text");
	     * 
	     * @param {@code string} - dir
	     * @param {@code string} - name_file
	     */
	    public static void delete_file (string dir, string name_file) {
	    	try {
		    	var file = File.new_for_path (dir + "/" + name_file);

	        	if (file.query_exists ()) {	
	        		file.delete ();
		        }

	        } catch (Error e) {
	            critical (e.message);
	        }
	    }
	}
}