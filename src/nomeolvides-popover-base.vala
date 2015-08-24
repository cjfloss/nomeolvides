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

[GtkTemplate ( ui = "/org/softwareperonista/nomeolvides/nomeolvides-popover-base.ui" )]
public class Nomeolvides.PopoverBase : Gtk.Popover {
  [GtkChild]
  public Entry entry_nombre;
  [GtkChild]
  protected Label label_nombre;
  [GtkChild]
	protected Button button_aplicar;
	protected string nombre_hecho;
	protected int64 id;
	public Base respuesta { get; protected set; }

	public PopoverBase ( Gtk.Widget relative_to ) {
	  GLib.Object ( relative_to: relative_to);
		this.entry_nombre.grab_focus ();
	}

	public virtual void set_datos ( Base objeto ) {
		this.entry_nombre.set_text ( objeto.nombre );
		this.nombre_hecho = objeto.nombre;
		this.button_aplicar.set_sensitive ( false );
		this.id = objeto.id;
	}

	
	public void borrar_datos () {
		this.entry_nombre.set_text ("");
	}

  [GtkCallback]
	public virtual void activar_button_aplicar () {
		if ( this.entry_nombre.get_text_length () > 0 && this.entry_nombre.get_text () != this.nombre_hecho ) {
			this.button_aplicar.set_sensitive ( true );
		} else {
			this.button_aplicar.set_sensitive ( false );
		}
	}

  [GtkCallback]
	protected void ocultar () {
		this.signal_cerrado ( this.get_relative_to () );
		this.hide ();
	}

  [GtkCallback]
	public virtual void aplicar () {}

	public signal bool signal_agregar ( Base objeto );
	public signal bool signal_actualizar ( Base objeto_viejo, Base objeto_nuevo );
	public signal void signal_cerrado ( Widget relative_to );
}
