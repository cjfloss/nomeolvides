/* -*- Mode: vala; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*-  */
/* nomeolvides
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

[GtkTemplate ( ui = "/ar/com/softwareperonista/nomeolvides/nomeolvides-dialog-hecho-lista-agregar.ui" )]
public class Nomeolvides.DialogHechoListaAgregar : Dialog {
  [GtkChild]
	private ComboBox combobox_listas;
	[GtkChild]
	private StackHechosDialog stack_hechos;
	public Array<Hecho> hechos;
	private int64 id_lista;
	
	public DialogHechoListaAgregar ( VentanaPrincipal ventana ) {
		Object (use_header_bar: 1);
		this.set_transient_for ( ventana as Window );
		this.hechos = new Array<Hecho> ();
	}

	public void setear_hechos ( Array<Hecho> hechos_elegidos ) {
		if ( hechos_elegidos.length == 1 ) {
			this.stack_hechos.set_label_un_hecho ( hechos_elegidos.index (0).nombre );
		} else {
			this.title = _("Add Facts to List");
			this.set_size_request ( 600, 200 );
			this.stack_hechos.set_treeview_muchos_hechos ( hechos_elegidos );
			this.stack_hechos.set_visible_child_name ( "page_muchos_hechos" );
		}

		for ( int i = 0; i < hechos_elegidos.length; i++ ) {
			this.hechos.append_val ( hechos_elegidos.index ( i ) );
		}
		this.show_all ();
	}

	public void setear_listas ( ListStoreListas liststore) {
		this.combobox_listas.set_model ( liststore );
	}

[GtkCallback]
	private void on_response (Dialog source, int response_id) {
        switch (response_id) {
    		case ResponseType.APPLY:
        		this.crear_respuesta ();
				break;
    		case ResponseType.CANCEL:
        		this.hide ();
        		break;
        }
    }

	private void crear_respuesta () {
		TreeIter iter;
		Value lista_elegida;
		Lista lista;

		this.combobox_listas.get_active_iter( out iter );
		this.combobox_listas.get_model ().get_value ( iter, 2, out lista_elegida );
		lista = lista_elegida as Lista;

		this.id_lista = lista.id;
	}

	public int64 get_id_lista () {
		return this.id_lista;
	}
}
