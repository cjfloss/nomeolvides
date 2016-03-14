/* -*- Mode: vala; indent-tabs-mode: t; c-basic-offset: 2; tab-width: 2 -*-  */
/*
 * nomeolvides-importar-hechos.vala
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

[GtkTemplate ( ui = "/org/softwareperonista/nomeolvides/nomeolvides-dialog-hechos-importar.ui" )]
public class Nomeolvides.DialogHechosImportar : Dialog {
  [GtkChild]
	private Button button_archivo;
 [GtkChild]
	private ComboBox combobox_colecciones;
	private string directorio;
	private string archivo;

	public DialogHechosImportar (VentanaPrincipal ventana, string directorio_actual, ListStoreColecciones colecciones_liststore ) {
		Object (use_header_bar: 1);
		this.set_transient_for ( ventana );

		this.directorio = directorio_actual;
		var coleccion = new Coleccion ( _("Select Colection"), true );
		colecciones_liststore.agregar_al_inicio ( coleccion , 0 );
		this.combobox_colecciones.set_model ( colecciones_liststore );
	}

  [GtkCallback]
	private void elegir_archivo () {
		var abrir_archivo = new FileChooserDialog ( _("Select a file"), null,
		                                            FileChooserAction.OPEN, _("Cancel"),
		                                            Gtk.ResponseType.CANCEL, _("Open"), 
		                                            ResponseType.ACCEPT	);
		abrir_archivo.set_current_folder ( this.directorio );

		if (abrir_archivo.run () == ResponseType.ACCEPT) {
			this.archivo = abrir_archivo.get_filename ();
			this.button_archivo.set_label ( this.archivo.slice ( this.archivo.last_index_of ( "/" ) + 1, this.archivo.length ));
		}
		abrir_archivo.destroy ();
	}

	public int64 get_coleccion () {
		TreeIter iter;
		Value value_coleccion;
		Coleccion coleccion;

		this.combobox_colecciones.get_active_iter( out iter );
		ListStoreColecciones liststore = this.combobox_colecciones.get_model () as ListStoreColecciones;
		liststore.get_value ( iter, 2, out value_coleccion );
		coleccion = value_coleccion as Coleccion;

		return coleccion.id;
	}

  [GtkCallback]
	private void set_sensitive_import () {
		if ( this.combobox_colecciones.active == 0 || this.button_archivo.get_label () == _("Choose File") ) {
			this.get_widget_for_response ( ResponseType.APPLY ).set_sensitive ( false );
		} else {
			this.get_widget_for_response ( ResponseType.APPLY ).set_sensitive ( true );
		}
	}

	public int64 get_coleccion_id () {
		return this.get_coleccion ();
	}

	public string get_filename () {
		return this.archivo;
	}
}
