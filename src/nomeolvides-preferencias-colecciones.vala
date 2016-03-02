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

public class Nomeolvides.PreferenciasColecciones : Nomeolvides.PreferenciasBase {
	public bool cambio_toggle { get; private set; }

	public PreferenciasColecciones ( ListStoreColecciones liststore_colecciones ) {
		var treeview_colecciones = new TreeViewColecciones ();
		treeview_colecciones.set_border_width ( 20 );
		treeview_colecciones.set_model ( liststore_colecciones );
		treeview_colecciones.coleccion_visible_toggle_change.connect ( signal_toggle_change );
		this.treeview = treeview_colecciones;
		this.scrolledwindow_preferencias_treeview.add ( this.treeview );
		this.scrolledwindow_preferencias_treeview.show ();
		this.cambio_toggle = false;

	#if DISABLE_GNOME3
		this.agregar_dialog = new DialogColeccionAgregar () as DialogBase;
		this.editar_dialog = new DialogColeccionEditar () as DialogBase;
		this.borrar_dialog = new DialogColeccionBorrar () as DialogBaseBorrar;
	#else
		this.agregar_dialog = new DialogColeccionAgregar ( this.toolbar_preferencias.boton_agregar ) as DialogBase;
		this.editar_dialog = new DialogColeccionEditar ( this.toolbar_preferencias.boton_editar ) as DialogBase;
		this.borrar_dialog = new DialogColeccionBorrar ( this.toolbar_preferencias.boton_borrar ) as DialogBaseBorrar;
	#endif
		this.conectar_signals ();
	}

	protected override bool agregar ( Base objeto ) {
		ListStoreColecciones liststore;
		if ( this.db.insert_coleccion ( objeto as Coleccion ) ) {
			objeto.id = this.db.ultimo_rowid();
			liststore = this.treeview.get_model () as ListStoreColecciones;
			liststore.agregar (objeto as Coleccion, 0);
			this.cambio_colecciones_signal ();
			return true;
		} else {
			return false;
		}
	}

	protected override bool actualizar ( Base objeto_viejo, Base objeto_nuevo ) {
		if ( this.db.update_coleccion ( objeto_nuevo as Coleccion ) ) {
			var liststore = this.treeview.get_model () as ListStoreColecciones;
			liststore.agregar ( objeto_nuevo as Coleccion, this.treeview.get_cantidad_hechos () );
			this.treeview.eliminar ( objeto_viejo );
			this.cambio_colecciones_signal ();
			return true;
		} else {
			return false;
		}
	}


	public override void borrar ( Base objeto ) {
		this.db.coleccion_a_borrar ( objeto as Coleccion );
		this.deshacer.guardar_borrado ( objeto, DeshacerTipo.BORRAR );
		this.deshacer.borrar_rehacer ();
		this.treeview.eliminar( objeto );
		this.cambio_colecciones_signal ();
	}

	protected override void efectuar_deshacer ( Base objeto ) {
		this.db.coleccion_no_borrar ( objeto as Coleccion );
		var liststore = this.treeview.get_model () as ListStoreColecciones;
		var cantidad_hechos = this.db.count_hechos_coleccion ( objeto as Coleccion );
		liststore.agregar ( objeto as Coleccion, cantidad_hechos );
	}

	protected override void efectuar_rehacer ( Base objeto ) {
		this.db.coleccion_a_borrar ( objeto as Coleccion );
		this.treeview.eliminar ( objeto as Coleccion );
	}

	protected override void elegir () {
		base.elegir ();

		if ( this.cambio_toggle ) {
			Coleccion coleccion = this.db.select_coleccion ( "WHERE rowid=\"" + this.treeview.get_elemento_id().to_string() + "\"");
			TreeViewColecciones treeview_colecciones = this.treeview as TreeViewColecciones;
			coleccion.visible = treeview_colecciones.get_coleccion_cursor_visible ();
			this.db.update_coleccion ( coleccion );
			this.cambio_toggle = false;
		}
	}

	private void signal_toggle_change () {
		this.cambio_toggle = true;
	}

	public signal void cambio_colecciones_signal ();
}

