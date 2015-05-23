/* -*- Mode: C; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*-  */
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

public class Nomeolvides.DialogBase : Gtk.Popover {
	protected Button aplicar_button;
	protected Button cancelar_button;
	protected string nombre_hecho;
	public Entry nombre_entry;
	protected int64 id;
	public Base respuesta { get; protected set; }
	protected Label nombre_label;

	public DialogBase ( Gtk.Widget relative_to ) {
		GLib.Object ( relative_to: relative_to);
		this.cancelar_button = new Button.with_mnemonic ( _("Cancel") );
		this.aplicar_button = new Button.with_mnemonic ( _("Apply") );
		this.aplicar_button.set_sensitive ( false );
		this.cancelar_button.set_border_width ( 5 );
		this.aplicar_button.set_border_width ( 5 );
		this.aplicar_button.clicked.connect ( this.aplicar );
		this.cancelar_button.clicked.connect ( this.ocultar );
		this.cancelar_button.get_style_context ().add_class ( "suggested-action" );

		this.nombre_hecho = "";
		this.modal = true;	
		this.nombre_label = new Label.with_mnemonic ( _("") + ": " );
		this.nombre_entry = new Entry ( );
		this.nombre_entry.set_max_length ( 30 );

		var grid = new Grid ( );
	
		this.closed.connect ( this.ocultar );
		this.nombre_entry.set_margin_bottom ( 10 );
		grid.set_margin_end ( 20 );
		grid.set_margin_start ( 20 );

		this.nombre_entry.changed.connect ( this.activar_boton_aplicar );
		grid.set_margin_top ( 30 );
		grid.set_margin_bottom ( 20 );
		grid.set_valign ( Align.CENTER );
		grid.set_halign ( Align.CENTER );

		grid.attach ( this.nombre_label, 0, 0, 1, 1 );
		grid.attach ( this.nombre_entry, 1, 0, 1, 1 );
		grid.set_column_homogeneous ( true );
	
		grid.attach ( this.cancelar_button, 0, 1, 1, 1 );
		grid.attach ( this.aplicar_button, 1, 1, 1, 1 );
		this.add ( grid );

		this.nombre_entry.grab_focus ();
	}

	public virtual void set_datos ( Base objeto ) {
		this.nombre_entry.set_text ( objeto.nombre );
		this.nombre_hecho = objeto.nombre;

		this.aplicar_button.set_sensitive ( false );
		this.id = objeto.id;
	}
	
	public void borrar_datos () {
		this.nombre_entry.set_text ("");
	}

	public virtual void activar_boton_aplicar () {
		if ( this.nombre_entry.get_text_length () > 0 && this.nombre_entry.get_text () != this.nombre_hecho ) {
			this.aplicar_button.set_sensitive ( true );
		} else {
			this.aplicar_button.set_sensitive ( false );
		}
	}

	protected void ocultar () {
		this.signal_cerrado ( this.get_relative_to () );
		this.hide ();
	}

	public virtual void aplicar () {}

	public signal bool signal_agregar ( Base objeto );
	public signal bool signal_actualizar ( Base objeto_viejo, Base objeto_nuevo );
	public signal void signal_cerrado ( Widget relative_to );
}
