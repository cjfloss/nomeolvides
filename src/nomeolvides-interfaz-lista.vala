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

[GtkTemplate ( ui = "/org/softwareperonista/nomeolvides/nomeolvides-interfaz-lista.ui")]
public class Nomeolvides.InterfazLista : Nomeolvides.InterfazBase {
	[GtkChild]
	private TreeViewBase treeview_listas;

	private Lista lista_actual;

	construct {
		this.lista_actual = new Lista ( "nombre" );
		this.lista_actual.id = -1;
		this.treeview_listas.cursor_changed.connect ( this.elegir_lista );
	}

	private void elegir_lista () {
		var lista = this.treeview_listas.get_elemento_id ();
		if ( this.lista_actual.id != lista ) {
			this.lista_actual.id = this.treeview_listas.get_elemento_id ();
			this.listas_cursor_changed ();
			this.mostrar_portada ();
		}
	}

	public void cargar_listas ( ListStoreListas listas ) {
		if ( !(listas.vacio) ) {
			this.treeview_listas.set_model ( listas );
		} else {
			this.hide ();
		}
	}

	public Lista get_lista_actual () {
		return this.lista_actual;
	}

	public signal void listas_cursor_changed ();
}
