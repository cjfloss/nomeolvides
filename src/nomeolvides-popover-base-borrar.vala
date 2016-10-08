/* -*- Mode: vala; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*-  */
/* Nomeolvides
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
 *
 * You should have received a copy of the GNU General Public License along
 * with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

using Gtk;
using Nomeolvides;

[GtkTemplate ( ui= "/ar/com/softwareperonista/nomeolvides/nomeolvides-popover-base-borrar.ui" )]
public class Nomeolvides.PopoverBaseBorrar : Popover {
	[GtkChild]
	protected Label label_pregunta;
	[GtkChild]
	protected Label label_nombre;
	[GtkChild]
	protected Label label_nombre_objeto;
	[GtkChild]
	protected Label label_cantidad_hechos;
	[GtkChild]
	protected Label label_cantidad_hechos_objeto;
	protected Base objeto;


	public PopoverBaseBorrar ( Widget relative_to ) {
		GLib.Object ( relative_to: relative_to);
		//grid.set_size_request ( 400, -1 );
	}

	public void set_datos ( Base objeto_a_borrar, int cantidad_label_cantidad_hechos ) {
		label_nombre_objeto.set_markup ( "<span font_weight=\"heavy\">"+ objeto_a_borrar.nombre +"</span>");
		label_cantidad_hechos_objeto.set_markup ( "<span font_weight=\"heavy\">"+ cantidad_label_cantidad_hechos.to_string () +"</span>");
		this.objeto = objeto_a_borrar;
	}

  [GtkCallback]
	protected void ocultar (){
		this.signal_cerrado ( this.get_relative_to () );
		this.hide ();
	}

  [GtkCallback]
	protected void aplicar () {
		this.signal_borrar ( this.objeto );
		this.ocultar ();
	}

	public signal void signal_borrar ( Base objeto );
	public signal void signal_cerrado ( Widget relative_to );
}
