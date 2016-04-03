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

[GtkTemplate ( ui = "/org/softwareperonista/nomeolvides/nomeolvides-actionbar.ui" ) ]
public class Nomeolvides.ActionBar : Gtk.ActionBar {
[GtkChild]
	public Boton boton_editar;
[GtkChild]
	public Boton boton_borrar;
[GtkChild]
	public Boton boton_enviar;
[GtkChild]
	public Boton boton_agregar_a_lista;

	public ActionBar () {
		this.show_all ();
	}


	public void set_botones_multiseleccion () {
      this.boton_editar.set_visible ( false );
//	  this.boton_borrar.set_visible ( true );
//    this.boton_enviar.set_visible ( true );
//	  this.boton_agregar_a_lista.set_visible ( true );
	}

	public void boton_agregar_a_lista_set_agregar ( ) {
		this.boton_agregar_a_lista.set_label (_("Add to list"));
	}

	public void boton_agregar_a_lista_set_quitar ( ) {
		this.boton_agregar_a_lista.set_label (_("Remove from list"));
	}
}
