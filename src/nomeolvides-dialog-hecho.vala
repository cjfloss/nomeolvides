/* -*- Mode: vala; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*-  */
/* nomeolvides
 *
 * Copyright (C) 2012 Andres Fernandez <andres@softwareperonista.com.ar>
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

[GtkTemplate ( ui = "/org/softwareperonista/nomeolvides/nomeolvides-dialog-hecho.ui" )]
public class Nomeolvides.DialogHecho : Dialog {
  [GtkChild]
	protected Entry entry_nombre;
	[GtkChild]
	protected TextView textview_descripcion;
	[GtkChild]
	protected ComboBox combobox_colecciones;
	[GtkChild]
	protected SelectorFecha selector_fecha;
	[GtkChild]
	protected Entry entry_fuente;
	[GtkChild]
	protected Button button_aplicar;
	public Hecho respuesta { get; protected set; }

	public DialogHecho (VentanaPrincipal ventana, ListStoreColecciones colecciones_liststore ) {
		Object (use_header_bar: 1);
		this.set_transient_for ( ventana as Window );
		this.combobox_colecciones.set_model ( colecciones_liststore );
	}

	protected void crear_respuesta() {
		if(this.entry_nombre.get_text_length () > 0) {
			this.respuesta  = new Hecho ( Utiles.sacarCaracterEspecial ( this.entry_nombre.get_text () ),
										  Utiles.sacarCaracterEspecial ( this.textview_descripcion.buffer.text ),
										  this.selector_fecha.get_anio (),
										  this.selector_fecha.get_mes (),
										  this.selector_fecha.get_dia (),
										  this.get_coleccion (),
										  Utiles.sacarCaracterEspecial ( this.entry_fuente.get_text () ) );
		}
	}

	protected int64 get_coleccion () {
		TreeIter iter;
		Value value_coleccion;
		Coleccion coleccion;

		this.combobox_colecciones.get_active_iter( out iter );
		ListStoreColecciones liststore = this.combobox_colecciones.get_model () as ListStoreColecciones;
		liststore.get_value ( iter, 2, out value_coleccion );
		coleccion = value_coleccion as Coleccion;

		return coleccion.id;
	}
}
