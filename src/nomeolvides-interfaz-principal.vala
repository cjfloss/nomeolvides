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
  public Stack stack_principal;
  [GtkChild]
  public InterfazFecha interfaz_fecha;
  [GtkChild]
  public InterfazLista interfaz_lista;

  construct {
	this.interfaz_fecha.hechos_selection_changed.connect ( this.elegir_hecho );
	this.interfaz_lista.hechos_selection_changed.connect ( this.elegir_hecho );
  }

 	private void elegir_hecho () {
		if ( this.stack_principal
					 .get_visible_child_name () == "page_interfaz_fecha") {
			this.interfaz_fecha.mostrar_actionbar ();
		} else {
			this.interfaz_lista.mostrar_actionbar ();
		}
	}
}
