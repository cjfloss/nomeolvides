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

public class Nomeolvides.BorrarHechoDialogo : Dialog {
	public BorrarHechoDialogo ( Hecho hecho_a_borrar, VentanaPrincipal ventana ) {
		this.set_modal ( true );
		this.set_transient_for ( ventana as Gtk.Window );
		Label pregunta = new Label.with_mnemonic ( "" );
		Label hecho_nombre = new Label.with_mnemonic ( "" );
		Label hecho_fecha = new Label.with_mnemonic ( "" );

		pregunta.set_markup ( "<big>" + _("Do you want to remove fact") + "</big>" );
		hecho_nombre.set_markup ( "<span font_weight=\"heavy\">"+ hecho_a_borrar.nombre +"</span>");
		hecho_fecha.set_markup ( "de <span font_style=\"italic\">"+ hecho_a_borrar.fecha_to_string() +"</span>");

		Box box = new Box ( Orientation.VERTICAL, 0 );

		box.pack_start ( pregunta, true, true, 15 );
		box.pack_start ( hecho_nombre, true, true, 0 );
		box.pack_start ( hecho_fecha, true, true, 0 );
		
		var contenido = this.get_content_area() as Box;
		contenido.pack_start(box, false, false, 0);
		
		this.add_button (Stock.CANCEL, ResponseType.REJECT);
		this.add_button (Stock.APPLY, ResponseType.APPLY);

		this.show_all ();
	}
}
