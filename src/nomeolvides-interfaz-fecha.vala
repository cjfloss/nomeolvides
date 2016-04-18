/* -*- Mode: vala; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*-  */
/* nomeolvides
 *
 * Copyright (C) 2013 Fernando Fernandez <fernando@softwareperonista.com.ar>
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
 *
 * You should have received a copy of the GNU General Public License along
 * with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

using Gtk;
using Nomeolvides;

[GtkTemplate ( ui = "/org/softwareperonista/nomeolvides/nomeolvides-interfaz-fecha.ui")]
public class Nomeolvides.InterfazFecha : Nomeolvides.InterfazBase {
  [GtkChild]
	private TreeViewAnios treeview_anios;
	private int anio_actual;

	construct {
		this.treeview_anios.cursor_changed.connect ( this.elegir_anio );
		this.anio_actual = 0;
	}

	private void elegir_anio () {
		if ( this.anio_actual != this.treeview_anios.get_anio () ||
					this.treeview_anios.get_anio () == 0 ) {
			this.anio_actual = this.treeview_anios.get_anio ();
			this.anios_cursor_changed();
			this.mostrar_portada ();
		}
	}

	public void cargar_anios ( Array<int> anios ) {
		this.treeview_anios.agregar_varios ( anios );
	}

	public int get_anio_actual () {
		return this.anio_actual;
	}

	public signal void anios_cursor_changed ();
}
