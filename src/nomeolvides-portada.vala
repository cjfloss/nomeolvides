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

[GtkTemplate ( ui = "/org/softwareperonista/nomeolvides/nomeolvides-portada.ui" ) ]
public class Nomeolvides.Portada : Grid {
  [GtkChild]
	private Label label_nombre;
	[GtkChild]
	private Label label_fecha;
	[GtkChild]
	private Label label_descripcion;
	[GtkChild]
	private Label label_fuente;
	
	public Portada () {}

	public bool set_datos_hecho ( Hecho a_mostrar ) {
		bool retorno = false;

		if ( a_mostrar != null ) {
			this.label_nombre.set_markup ( "<span font_size=\"x-large\" font_weight=\"heavy\">" + a_mostrar.nombre + "</span>" );
			this.label_fecha.set_markup ( "<span font_style=\"italic\">"+ a_mostrar.fecha_to_string () + "</span>" );
			this.label_descripcion.set_markup ( "<span>" + a_mostrar.descripcion + "</span>" );
			if ( a_mostrar.fuente != "" ) {
				this.label_fuente.set_markup ( _("Source") + ": " + "<span font_style=\"italic\">" + a_mostrar.fuente + "</span>" );
			} else {
				this.label_fuente.set_markup ( "" );
			}

			retorno = true;
		}

		return retorno;
	}
}
