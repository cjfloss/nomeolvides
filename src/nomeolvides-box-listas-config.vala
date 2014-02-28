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
 *   bullit - 39 escalones - silent love (japonesa) 
 * You should have received a copy of the GNU General Public License along
 * with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

using Gtk;
using Nomeolvides;

public class Nomeolvides.ListasConfig: Gtk.Box {
	public TreeViewListas listas_view { get; private set; }
	private ToolButton aniadir_lista_button;
	private ToolButton deshacer_button;
	private ToolButton rehacer_button;
	private ToolButton editar_lista_button;
	private ToolButton borrar_lista_button;
	public bool cambios { get; private set; }
	public Button boton_aniadir;
	private AccionesDB db;
	private Deshacer<Lista> deshacer;
		
	public ListasConfig ( ListStoreListas liststore_lista ) {
		this.db = new AccionesDB ( Configuracion.base_de_datos() );
		this.set_orientation ( Orientation.VERTICAL );

		Toolbar toolbar = new Toolbar ();
		this.aniadir_lista_button = new ToolButton.from_stock ( Stock.ADD );
		this.deshacer_button = new ToolButton.from_stock ( Stock.UNDO );
		this.rehacer_button = new ToolButton.from_stock ( Stock.REDO );
		this.editar_lista_button = new ToolButton.from_stock ( Stock.EDIT );
		this.borrar_lista_button = new ToolButton.from_stock ( Stock.DELETE );
		aniadir_lista_button.is_important = true;
		this.deshacer_button.is_important = true;
		this.rehacer_button.is_important = true;
		editar_lista_button.is_important = true;
		borrar_lista_button.is_important = true;
		editar_lista_button.set_visible_horizontal ( false );
		borrar_lista_button.set_visible_horizontal ( false );
		this.deshacer_button.set_sensitive ( false );
		this.rehacer_button.set_sensitive ( false );
		SeparatorToolItem separador = new SeparatorToolItem ();
		separador.set_expand ( true );
		separador.draw = false;

		this.deshacer = new Deshacer<Lista> ();

		editar_lista_button.clicked.connect ( edit_lista_dialog );
		borrar_lista_button.clicked.connect ( borrar_lista_dialog );
		aniadir_lista_button.clicked.connect ( add_lista_dialog );
		this.deshacer_button.clicked.connect ( this.deshacer_cambios );
		this.rehacer_button.clicked.connect ( this.rehacer_cambios );

		toolbar.add ( aniadir_lista_button );
		toolbar.add ( deshacer_button );
		toolbar.add ( rehacer_button );
		toolbar.add ( separador );
		toolbar.add ( editar_lista_button );
		toolbar.add ( borrar_lista_button );
		
		this.conectar_signals ();
		this.cambios = false;
		this.listas_view = new TreeViewListas ();
		this.listas_view.set_model ( liststore_lista );
		this.listas_view.cursor_changed.connect ( elegir_lista );

		var scroll_listas_view = new ScrolledWindow (null,null);
		scroll_listas_view.set_policy (PolicyType.NEVER, PolicyType.AUTOMATIC);
		scroll_listas_view.add ( this.listas_view );
 
		this.add ( toolbar );
		this.pack_start ( scroll_listas_view, true, true, 0);
		this.show_all ();
	}

	public void actualizar_model ( ListStoreListas liststore_listas ) {
		this.listas_view.set_model ( liststore_listas );
	}

	private void conectar_signals () {
		this.deshacer.deshacer_sin_items.connect ( this.desactivar_deshacer );
		this.deshacer.deshacer_con_items.connect ( this.activar_deshacer );
		this.deshacer.rehacer_sin_items.connect ( this.desactivar_rehacer );
		this.deshacer.rehacer_con_items.connect ( this.activar_rehacer );
	}

	private void add_lista_dialog () {
		ListStoreListas liststore;
		Lista lista;
		
		var add_dialog = new AddListaDialog ( );
		add_dialog.show_all ();

		if (add_dialog.run() == ResponseType.APPLY) {
			lista = add_dialog.respuesta;
			if ( this.db.insert_lista ( lista )) {
				lista.id = this.db.ultimo_rowid();
				liststore = this.listas_view.get_model () as ListStoreListas;
				liststore.agregar ( lista, 0 );
				this.cambios = true;
			}
		}
		
		add_dialog.destroy ();
	}

	private void edit_lista_dialog () {
		ListStoreListas liststore;
		var lista = this.listas_view.get_lista_cursor ();
		
		var edit_dialog = new EditListaDialog ();
		edit_dialog.set_datos ( lista );
		edit_dialog.show_all ();

		if (edit_dialog.run() == ResponseType.APPLY) {
			if ( this.db.update_lista ( edit_dialog.respuesta )) {
				liststore = this.listas_view.get_model () as ListStoreListas;
				var cantidad_hechos = this.listas_view.get_hechos_lista ();
				this.listas_view.eliminar_lista ( lista );
				liststore.agregar (edit_dialog.respuesta, cantidad_hechos);
				this.cambios = true;
			}
		}	
		edit_dialog.destroy ();
	}

	private void borrar_lista_dialog () {
		Lista lista = this.listas_view.get_lista_cursor ();
		var borrar_dialog = new BorrarListaDialogo ( lista, this.listas_view.get_hechos_lista () );
		borrar_dialog.show_all ();

		if (borrar_dialog.run() == ResponseType.APPLY) {
			this.db.lista_a_borrar ( lista );
			this.deshacer.guardar_borrado ( lista, DeshacerTipo.BORRAR );
			this.deshacer.borrar_rehacer ();
			this.listas_view.eliminar_lista ( this.listas_view.get_lista_cursor () );
		}
		borrar_dialog.destroy ();

		this.cambios = true;
	}

	private void set_buttons_visible ( bool cambiar ) {
		this.editar_lista_button.set_visible_horizontal ( cambiar );
		this.borrar_lista_button.set_visible_horizontal ( cambiar );
	}

	private void elegir_lista () {
		if(this.listas_view.get_lista_cursor () != null) {
			this.set_buttons_visible ( true );
		} else {
			this.set_buttons_visible ( false );		
		}
	}

	public void actualizar_liststore () {
		var liststore = new ListStoreListas ();
		var listas = this.db.select_listas ();

		for ( int i=0; i < listas.length; i++ ) {
			var lista = listas.index (i);
			var cantidad_hechos = this.db.count_hechos_lista ( lista );
			liststore.agregar ( lista, cantidad_hechos );			
		}

		this.listas_view.set_model ( liststore );
	}

	public void deshacer_cambios () {
		DeshacerItem<Lista> item;
		bool hay_listas_deshacer = this.deshacer.deshacer ( out item ); 
		if ( hay_listas_deshacer ){
			this.db.lista_no_borrar ( item.get_borrado() );
			var liststore = this.listas_view.get_model () as ListStoreListas;
			var cantidad_hechos = this.db.count_hechos_lista ( item.get_borrado() );
			liststore.agregar ( item.get_borrado(), cantidad_hechos);
			this.cambios = true;
		}
	}

	public void rehacer_cambios () {
		DeshacerItem<Lista> item;

		bool hay_listas_rehacer = this.deshacer.rehacer ( out item ); 
		if ( hay_listas_rehacer ){
			this.db.lista_a_borrar ( item.get_borrado() );
			this.listas_view.eliminar_lista ( item.get_borrado() );
			this.cambios = true;
		}
	}

	public void activar_deshacer () {
		this.deshacer_button.set_sensitive ( true );
	}

	public void desactivar_deshacer () {
		this.deshacer_button.set_sensitive ( false );
	}

	public void activar_rehacer () {
		this.rehacer_button.set_sensitive ( true );
	}

	public void desactivar_rehacer () {
		this.rehacer_button.set_sensitive ( false );
	}
}
