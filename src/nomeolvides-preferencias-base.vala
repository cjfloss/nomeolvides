/* -*- Mode: vala; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*-  */
/* nomeolvides
 *
 * Copyright (C) 2014 Andres Fernandez <andres@softwareperonista.com.ar>
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

[GtkTemplate ( ui = "/org/softwareperonista/nomeolvides/nomeolvides-preferencias-base.ui" )]
public class Nomeolvides.PreferenciasBase : Gtk.Grid {
	protected TreeViewBase treeview { get; protected set; }
	[GtkChild]
	protected ScrolledWindow scrolledwindow_preferencias_treeview;
	[GtkChild]
	protected Nomeolvides.Toolbar toolbar_preferencias;
	protected AccionesDB db;
	protected Deshacer<Base> deshacer;
	protected DialogBase agregar_dialog;
	protected DialogBase editar_dialog;
	protected DialogBaseBorrar borrar_dialog;

	public PreferenciasBase () {
		this.db = new AccionesDB ( Configuracion.base_de_datos() );
		this.deshacer = new Deshacer<Base> ();
	}

	public void actualizar_model ( ListStoreBase liststore ) {
		this.treeview.set_model ( liststore );
	}

	protected void conectar_signals () {
		this.toolbar_preferencias.boton_agregar.activado.connect ( this.add_dialog );
		this.toolbar_preferencias.boton_borrar.activado.connect ( this.delete_dialog );
		this.toolbar_preferencias.boton_editar.activado.connect ( this.edit_dialog );
		this.toolbar_preferencias.boton_deshacer.activado.connect ( this.deshacer_cambios );
		this.toolbar_preferencias.boton_rehacer.activado.connect ( this.rehacer_cambios );

		this.deshacer.deshacer_sin_items.connect ( this.toolbar_preferencias.desactivar_deshacer );
		this.deshacer.deshacer_con_items.connect ( this.toolbar_preferencias.activar_deshacer );
		this.deshacer.rehacer_sin_items.connect ( this.toolbar_preferencias.desactivar_rehacer );
		this.deshacer.rehacer_con_items.connect ( this.toolbar_preferencias.activar_rehacer );
		this.treeview.cursor_changed.connect ( this.elegir );
	#if DISABLE_GNOME3
	#else
		this.agregar_dialog.signal_cerrado.connect ( this.desactivar_boton );
		this.borrar_dialog.signal_cerrado.connect ( this.desactivar_boton );
		this.editar_dialog.signal_cerrado.connect ( this.desactivar_boton );
		this.agregar_dialog.signal_agregar.connect ( this.agregar );
		this.editar_dialog.signal_actualizar.connect ( this.actualizar );
		this.borrar_dialog.signal_borrar.connect ( this.borrar );
	#endif
	}

	protected virtual void add_dialog () {
		this.agregar_dialog.show_all ();
	#if DISABLE_GNOME3
		if ( agregar_dialog.run() == ResponseType.APPLY ) {
 			this.agregar ( agregar_dialog.respuesta );
		}
		this.agregar_dialog.hide ();
		this.toolbar_preferencias.boton_agregar.set_active ( false );
	#endif

		this.agregar_dialog.borrar_datos ();
	}

	public virtual void edit_dialog () {
		Base objeto = this.treeview.get_elemento ();
		this.editar_dialog.set_datos ( objeto );
		this.editar_dialog.show_all ();

	#if DISABLE_GNOME3
		if (this.editar_dialog.run() == ResponseType.APPLY) {
			if ( this.actualizar ( objeto, this.editar_dialog.respuesta ) ) {
				this.cambio_signal ();
			}
		}
		this.toolbar_preferencias.boton_editar.set_active ( false );
		this.editar_dialog.hide ();
	#endif
	}

	private void delete_dialog () {
		Base objeto = this.treeview.get_elemento ();
		this.borrar_dialog.set_datos ( objeto, this.treeview.get_cantidad_hechos () );
		this.borrar_dialog.show_all ();
	#if DISABLE_GNOME3
		if ( this.borrar_dialog.run() == ResponseType.APPLY ) {
			this.borrar ( objeto );
			this.cambio_signal ();
		}
		this.borrar_dialog.hide ();
		this.toolbar_preferencias.boton_borrar.set_active ( false );
	#endif
	}

	protected virtual void elegir () {
		if( this.treeview.get_selection ().count_selected_rows () > -1 ) {
			this.toolbar_preferencias.set_botones_visible ();
		} else {
			this.toolbar_preferencias.set_botones_invisible ();
		}
	}

	void deshacer_cambios () {
		DeshacerItem<Base> item;
		bool hay_colecciones_deshacer = this.deshacer.deshacer ( out item );
		if ( hay_colecciones_deshacer ){
			this.efectuar_deshacer ( item.get_borrado () );
			this.cambio_signal ();
		}
	}

	public void rehacer_cambios () {
		DeshacerItem<Base> item;

		bool hay_colecciones_rehacer = this.deshacer.rehacer ( out item );
		if ( hay_colecciones_rehacer ){
			this.efectuar_rehacer ( item.get_borrado () );
			this.cambio_signal ();
		}
	}

	public void set_buttons_invisible () {
		this.toolbar_preferencias.set_botones_invisible ();
	}
#if DISABLE_GNOME3
#else
	protected void desactivar_boton ( Widget relative_to ) {
		var boton = relative_to as ToggleButton;
		boton.set_active ( false );
	}
#endif

	protected virtual bool agregar ( Base objeto ) {
		return false;
	}

	protected virtual bool actualizar ( Base objeto_viejo, Base objeto_nuevo ) {
		return false;
	}

	protected virtual void borrar ( Base objeto ) {}
	protected virtual void efectuar_deshacer ( Base objeto ) {}
	protected virtual void efectuar_rehacer ( Base objeto ) {}

	public signal void cambio_signal ();
}
