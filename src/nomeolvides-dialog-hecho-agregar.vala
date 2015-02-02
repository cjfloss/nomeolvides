/* -*- Mode: vala; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*-  */
/* nomeolvides
 *
 * Copyright (C) 2012 Fernando Fernandez <fernando@softwareperonista.com.ar>
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

public class Nomeolvides.DialogHechoAgregar : Nomeolvides.DialogHecho {

	public DialogHechoAgregar ( VentanaPrincipal ventana, ListStoreColecciones colecciones ) {
		base (ventana, colecciones);

		this.set_title (_("Add a Historical Fact"));

		this.response.connect(on_response);
		this.nombre_entry.activate.connect(on_activate);

#if DISABLE_GNOME3
		this.add_button ( _("Add") , ResponseType.APPLY);
#else
		var boton = this.add_button ( _("Add") , ResponseType.APPLY);
		boton.get_style_context ().add_class ( "suggested-action" );
#endif
	}


	private void on_response (Dialog source, int response_id)
	{
		switch (response_id)
		{
			case ResponseType.APPLY:
				aplicar();
				break;
			case ResponseType.CANCEL:
				destroy();
				break;
		}
	}

	private void on_activate () {
		if (this.nombre_entry.text_length > 0 && this.descripcion_textview.buffer.text.length > 0){
			this.response (ResponseType.APPLY);
		}
	}

	private void aplicar ()
	{
		this.crear_respuesta ();
	}
}
