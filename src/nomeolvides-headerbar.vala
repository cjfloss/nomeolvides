/* -*- Mode: vala; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*-  */
/*
 * nomeolvides-box-toolbar.vala
 * Copyright (C) 2014 Fernando Fernandez <fernando@softwareperonista.com.ar>
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

[GtkTemplate ( ui = "/ar/com/softwareperonista/nomeolvides/nomeolvides-headerbar.ui" ) ]
public class Nomeolvides.HeaderBar : Gtk.HeaderBar {
[GtkChild]
	public Boton boton_agregar;
[GtkChild]
	public Boton boton_deshacer;
[GtkChild]
	public Boton boton_rehacer;
[GtkChild]
	public Boton boton_editar;
[GtkChild]
	public Boton boton_borrar;
[GtkChild]
	public Boton boton_enviar;
[GtkChild]
	public Boton boton_agregar_a_lista;

	public HeaderBar () {
	  this.set_botones_invisible ();
	}

	public void set_label_anio ( string anio = "0" ) {
		if ( anio != "0") {
			this.set_title ( _("Year") + ": " + anio );
		} else if ( this.get_title () != _("Nomeolvides") ) {
			this.set_title ( "" );
		}
	}

	public void set_label_lista ( string lista = "" ) {;
		if ( lista != "") {
			this.set_title ( lista );
		} else if ( this.get_title () != _("Nomeolvides") ) {
			this.set_title ( "" );
		}
	}

	public new void set_botones_visible () {
		this.set_botones_multiseleccion_visible ();
		this.boton_editar.set_visible ( true );
	}

	public void set_botones_multiseleccion_visible () {
		this.boton_editar.set_visible ( false );
		this.boton_borrar.set_visible ( true );
	  this.boton_enviar.set_visible ( true );
	  this.boton_agregar_a_lista.set_visible ( true );
	}
  [GtkCallback]
	public new void set_botones_invisible () {
		this.boton_editar.set_visible ( false );
		this.boton_borrar.set_visible ( false );
		this.boton_enviar.set_visible ( false );
		this.boton_agregar_a_lista.set_visible ( false );
	}

	public void boton_agregar_a_lista_set_agregar ( ) {
		this.boton_agregar_a_lista.set_label (_("Add to list"));
	}

	public void boton_agregar_a_lista_set_quitar ( ) {
		this.boton_agregar_a_lista.set_label (_("Remove from list"));
	}

	public void activar_deshacer () {
		this.boton_deshacer.set_sensitive ( true );
	}

	public void desactivar_deshacer () {
		this.boton_deshacer.set_sensitive ( false );
	}

	public void activar_rehacer () {
		this.boton_rehacer.set_sensitive ( true );
	}

	public void desactivar_rehacer () {
		this.boton_rehacer.set_sensitive ( false );
	}
}
