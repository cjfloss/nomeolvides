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

public class Nomeolvides.DialogHechoEditar : Nomeolvides.DialogHecho {
	private int64 hecho_id;

	public DialogHechoEditar ( VentanaPrincipal ventana, ListStoreColecciones colecciones ) {
		base (ventana, colecciones );
		this.set_title (_("Edit Fact"));
		this.button_aplicar.set_label ("Edit");

		this.response.connect(on_response);
	}

	public void set_datos ( Hecho hecho_a_editar ) {
		this.entry_nombre.set_text( hecho_a_editar.nombre );
		this.textview_descripcion.buffer.text= hecho_a_editar.descripcion;
		this.selector_fecha.set_anio( int.parse ( hecho_a_editar.fecha.get_anio () ) );
		this.selector_fecha.set_mes( int.parse ( hecho_a_editar.fecha.get_mes_numerico () ) );
		this.selector_fecha.set_dia( int.parse ( hecho_a_editar.fecha.get_dia () ) );
		this.entry_fuente.set_text ( hecho_a_editar.fuente );
		this.set_coleccion_de_hecho ( hecho_a_editar.coleccion );
		this.hecho_id = hecho_a_editar.id;
	}
	
	private void on_response (Dialog source, int response_id) {
        switch (response_id)
		{
			case ResponseType.APPLY:
				modificar();
				break;
			case ResponseType.CANCEL:
				destroy();
				break;
        }
    }
		
	private void modificar () {
		this.crear_respuesta ();
		this.respuesta.id = this.hecho_id;
	}

	protected void set_coleccion_de_hecho ( int64 coleccion_id ) {
		ListStoreColecciones liststore = this.combobox_colecciones.get_model () as ListStoreColecciones;

		this.combobox_colecciones.set_active ( liststore.indice_de_id ( coleccion_id ) );
	}
}
