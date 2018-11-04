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
     * The {@code URLUtil} class is responsible for manipulating urls.
     *
     * @since 0.1.0
     */
    public class URLUtil {

    	/**
	     * Check if url is valid.
	     *
	     * Exemple:
	     * > URLUtil.check_url_with_regex("https://elementary.io");
	     * 
	     * @param {@code string} url 
	     */
		public static bool check_url_with_regex (string url) {
			try {
	            var regex = new Regex ("""(http|ftp|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?""");
	            
	            if (!regex.match (url)) {
		            return false;
		        }

	        } catch (RegexError e) {
	            GLib.message("Erro: %s", e.message);
	        }

	        return true;
	    }
	}
}