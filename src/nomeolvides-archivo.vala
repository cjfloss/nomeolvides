/* -*- Mode: vala; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*-  */
/* nomeolvides
 *
 * Copyright (C) 2013 Andres Fernandez <andres@softwareperonista.com.ar>
 *
 * nomeolvides is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * nomeolvides is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 *   bullit - 39 escalones - silent love (japonesa) 
 * You should have received a copy of the GNU General Public License along
 * with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

using Gtk;
using Nomeolvides;

public class Nomeolvides.Archivo : GLib.Object{ 
	public static void crear_archivo ( string path, string datos = "" ) {
		var archivo = File.new_for_path ( path );
		try {
			archivo.create (FileCreateFlags.NONE);
		} catch (Error e) {
			error (e.message);
		}
	}

	public static void crear_directorio ( string path ) {
		var directorio = File.new_for_path ( path );
		try {
			directorio.make_directory ();
		}  catch (Error e) {
			error (e.message);
		}
	}

	public static void escribir_archivo ( string path, string datos ) {
		try {
			FileUtils.set_contents ( path, datos );
		} catch ( Error e ) {
			error ( e.message );
		}
	}

	public static bool existe ( string path ) {
		var archivo = File.new_for_path ( path );
		var retorno = archivo.query_exists ();

		return retorno;
	}
}
