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

[GtkTemplate ( ui = "/org/softwareperonista/nomeolvides/nomeolvides-interfaz-principal.ui")]
public class Nomeolvides.InterfazPrincipal : Gtk.Grid {
  [GtkChild]
	private TreeViewHechos treeview_hechos;
  [GtkChild]
	private Revealer revealer_portada;
	[GtkChild]
	private Portada portada;
  [GtkChild]
	private NotebookAniosListas notebook_anios_listas;
	private int anio_actual;
	private Lista lista_actual;
	private AccionesDB db;

	construct {
		this.db = new AccionesDB ( Configuracion.base_de_datos() );

		this.treeview_hechos.get_selection ().changed.connect ( this.elegir_hecho );
		this.notebook_anios_listas.treeview_anios.cursor_changed.connect ( this.elegir_anio );
		this.notebook_anios_listas.treeview_listas.cursor_changed.connect ( this.elegir_lista );
		this.treeview_hechos.row_activated.connect ( mostrar_vista );
		this.notebook_anios_listas.switch_page.connect ( cambiar_pestania );

		this.anio_actual = 0;
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
	private void elegir_anio () {
		if ( this.anio_actual != this.notebook_anios_listas.treeview_anios.get_anio () || this.notebook_anios_listas.treeview_anios.get_anio () == 0 ) {
			this.anio_actual = this.notebook_anios_listas.treeview_anios.get_anio ();
			this.lista_actual = null; //ningina lista
			this.anios_cursor_changed();
			this.mostrar_scroll_vista ( false );
		}
	}

	private void elegir_lista () {
			var lista = this.db.select_lista ( "WHERE rowid=\"" 
		                                                + this.notebook_anios_listas.treeview_listas.get_elemento_id ().to_string() + "\"");
		if ( this.lista_actual != lista ) {
			this.lista_actual = lista;
			this.anio_actual = 0; //ningún anio
			this.listas_cursor_changed ();
			this.mostrar_scroll_vista ( false );
		}
	}

	private void cambiar_pestania () {
		switch ( this.notebook_anios_listas.get_current_page () ) {
		case 0:
			this.elegir_lista ();
			break;
		case 1:
			this.elegir_anio ();
			break;
		}
	}

	private void mostrar_vista () {
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

	public void mostrar_scroll_vista ( bool mostrar ) {	
		if ( mostrar == true ) {
			this.revealer_portada.set_reveal_child ( true );
		} else {
			this.revealer_portada.set_reveal_child ( false );
		}	
	}

	public void cargar_lista_anios ( Array<int> anios ) {
		this.notebook_anios_listas.treeview_anios.agregar_varios ( anios );
		this.listas_cursor_changed ();
	}

	public void cargar_listas ( ListStoreListas listas ) {
		if ( !(listas.vacio) ) {			
			this.notebook_anios_listas.treeview_listas.set_model ( listas );
			this.notebook_anios_listas.get_nth_page (1).show ();
		} else {
			this.notebook_anios_listas.get_nth_page (1).hide ();
			this.elegir_anio ();
		}
		this.anios_cursor_changed ();
	}

	public void cargar_lista_hechos ( Array<Hecho> hechos ) {
		this.treeview_hechos.mostrar_hechos ( hechos );
	}

	public int get_anio_actual () {
		return this.anio_actual;
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

	public string get_nombre_pestania () {
		return this.notebook_anios_listas.get_tab_label_text ( this.notebook_anios_listas.get_nth_page
		                                               ( this.notebook_anios_listas.get_current_page () ) );
	}

	public void limpiar_treeview_hechos () {
		this.treeview_hechos.limpiar ();
	}

	public Array<Hecho> get_hechos_seleccionados () {
		return this.treeview_hechos.get_hechos_seleccionados ();
	}

	public signal void hechos_selection_changed ();
	public signal void anios_cursor_changed ();
	public signal void listas_cursor_changed ();
}
