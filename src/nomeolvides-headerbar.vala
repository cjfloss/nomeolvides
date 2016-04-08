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

[GtkTemplate ( ui = "/org/softwareperonista/nomeolvides/nomeolvides-headerbar.ui" ) ]
public class Nomeolvides.HeaderBar : Gtk.HeaderBar {
[GtkChild]
	public Boton boton_agregar;
[GtkChild]
	public Boton boton_deshacer;
[GtkChild]
	public Boton boton_rehacer;
[GtkChild]
  public StackSwitcher headerbar_stackswitcher;

	public HeaderBar () {}


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
