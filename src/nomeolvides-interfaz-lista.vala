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
public class Nomeolvides.InterfazLista : Gtk.Grid {
	[GtkChild]
	private TreeViewHechos treeview_hechos;
	[GtkChild]
	private Revealer revealer_actionbar;
	[GtkChild]
	public Nomeolvides.ActionBar actionbar;
	[GtkChild]
	private Revealer revealer_portada;
	[GtkChild]
	private Portada portada;
	[GtkChild]
	private TreeViewBase treeview_listas;

	private Lista lista_actual;

	construct {
		this.lista_actual = new Lista ( "nombre" );
		this.lista_actual.id = -1;
		this.treeview_hechos.get_selection ().changed.connect ( this.elegir_hecho );
		this.treeview_listas.cursor_changed.connect ( this.elegir_lista );
		this.treeview_hechos.row_activated.connect ( mostrar_portada );
	}

	private void elegir_hecho () {
		this.hechos_selection_changed();
		if ( this.treeview_hechos.get_hechos_seleccionados ().length == 1 ) {
			if (this.revealer_portada.get_child_revealed () == true ) {
				this.mostrar_hecho ();
			}
		} else {
			this.revealer_portada.set_reveal_child ( false );
		}
	}

	private void elegir_lista () {
		var lista = this.treeview_listas.get_elemento_id ();
		if ( this.lista_actual.id != lista ) {
			this.lista_actual.id = this.treeview_listas.get_elemento_id ();
			this.listas_cursor_changed ();
			this.mostrar_portada ();
		}
	}

	public void mostrar_portada () {
			if ( this.revealer_portada.get_child_revealed () == true ) {
				this.revealer_portada.set_reveal_child ( false );
			} else {
				this.mostrar_hecho ();
			}
	}

	private void mostrar_hecho () {
		Hecho hecho_a_mostrar;
		this.treeview_hechos.get_hecho_cursor( out hecho_a_mostrar );

		if ( hecho_a_mostrar != null ) {
			this.portada.set_datos_hecho ( hecho_a_mostrar );
			this.revealer_portada.set_reveal_child ( true );
		}
	}

	public void cargar_listas ( ListStoreListas listas ) {
		if ( !(listas.vacio) ) {
			this.treeview_listas.set_model ( listas );
		} else {
			this.hide ();
		}
	}

	public void cargar_hechos ( Array<Hecho> hechos ) {
		this.treeview_hechos.mostrar_hechos ( hechos );
	}

	public Lista get_lista_actual () {
		return this.lista_actual;
	}

	public TreePath get_hecho_actual ( out Hecho hecho ) {
		return this.treeview_hechos.get_hecho_cursor (out hecho );
	}

	public TreeSelection get_hechos_selection ( ) {
		return this.treeview_hechos.get_selection ();
	}

	public void limpiar_treeview_hechos () {
		this.treeview_hechos.limpiar ();
	}

	public Array<Hecho> get_hechos_seleccionados () {
		return this.treeview_hechos.get_hechos_seleccionados ();
	}

	public void mostrar_actionbar ( ) {
		if ( this.treeview_hechos.get_hechos_seleccionados ().length > 0 ) {
			this.actionbar.set_botones_uniseleccion ();
			this.revealer_actionbar.set_reveal_child ( true );

			if ( this.treeview_hechos.get_hechos_seleccionados ().length > 1 ) {
				this.actionbar.set_botones_multiseleccion ();
			}
		} else {
			this.revealer_actionbar.set_reveal_child ( false );
		}
	}

	public signal void hechos_selection_changed ();
	public signal void listas_cursor_changed ();
}
