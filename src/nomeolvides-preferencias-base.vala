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

[GtkTemplate ( ui = "/ar/com/softwareperonista/nomeolvides/nomeolvides-preferencias-base.ui" )]
public class Nomeolvides.PreferenciasBase : Gtk.Grid {
	protected TreeViewBase treeview { get; protected set; }
	[GtkChild]
	protected ScrolledWindow scrolledwindow_preferencias_treeview;
	[GtkChild]
	protected Nomeolvides.Toolbar toolbar_preferencias;
	protected AccionesDB db;
	protected Deshacer<Base> deshacer;
	protected PopoverBase popover_agregar;
	protected PopoverBase popover_editar;
	protected PopoverBaseBorrar popover_borrar;

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

		this.popover_agregar.signal_cerrado.connect ( this.desactivar_boton );
		this.popover_borrar.signal_cerrado.connect ( this.desactivar_boton );
		this.popover_editar.signal_cerrado.connect ( this.desactivar_boton );
		this.popover_agregar.signal_agregar.connect ( this.agregar );
		this.popover_editar.signal_actualizar.connect ( this.actualizar );
		this.popover_borrar.signal_borrar.connect ( this.borrar );
	}

	protected virtual void add_dialog () {
		this.popover_agregar.show_all ();

		this.popover_agregar.borrar_datos ();
	}

	public virtual void edit_dialog () {
		Base objeto = this.treeview.get_elemento ();
		this.popover_editar.set_datos ( objeto );
		this.popover_editar.show_all ();
	}

	private void delete_dialog () {
		Base objeto = this.treeview.get_elemento ();
		this.popover_borrar.set_datos ( objeto, this.treeview.get_cantidad_hechos () );
		this.popover_borrar.show_all ();
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

	protected void desactivar_boton ( Widget relative_to ) {
		var boton = relative_to as ToggleButton;
		boton.set_active ( false );
	}

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
