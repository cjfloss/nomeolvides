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

public class Nomeolvides.VentanaPrincipal : Gtk.ApplicationWindow {
	private Box main_box { get; private set; }
	public Toolbar toolbar { get; private set; }
	public InterfazPrincipal anios_hechos { get; private set; }
	private int anio_actual;
	private Lista lista_actual;
	private LineaDeTiempo linea;

	public VentanaPrincipal ( Gtk.Application app )
	{
		Object (application: app);
		this.set_application (app);
		this.set_title ("Nomeolvides v" + Config.VERSION );
		this.set_position (WindowPosition.CENTER);
		this.set_default_size (1100,600);
		this.set_size_request (500,350);

		this.anio_actual = 0;

		this.main_box = new Box ( Orientation.VERTICAL, 0 );

		this.anios_hechos = new InterfazPrincipal ();
		
		this.add (main_box);

		this.linea = new LineaDeTiempo ();
		
		this.toolbar = new Nomeolvides.Toolbar ();

		this.toolbar.agregar_send_button ();
		this.toolbar.agregar_list_button ();
	#if DISABLE_GNOME3
		this.toolbar.agregar_titulo ();

		var menu_barra = new MenuBar ();
		this.main_box.pack_start ( menu_barra, false, false, 0 );

		var menu_archivo_item = new Gtk.MenuItem.with_mnemonic ( _("File"));
		menu_barra.add( menu_archivo_item );
		var menu_archivo = new Gtk.Menu ();
		menu_archivo_item.set_submenu ( menu_archivo );

		var menu_exportar = new Gtk.MenuItem.with_mnemonic ( _("Export Facts") );
		menu_exportar.activate.connect ( this.menu_exportar_activate_signal );
		menu_archivo.add ( menu_exportar );

		var menu_importar = new Gtk.MenuItem.with_mnemonic ( _("Import facts") );
		menu_importar.activate.connect ( this.menu_importar_activate_signal );
		menu_archivo.add ( menu_importar );

		var menu_salir = new Gtk.MenuItem.with_mnemonic ( _("Quit") );
		menu_salir.activate.connect ( this.menu_salir_activate_signal );
		menu_archivo.add ( menu_salir );

		var menu_editar_item = new Gtk.MenuItem.with_mnemonic ( _("Edit") );
		menu_barra.add( menu_editar_item );
		var menu_editar = new Gtk.Menu ();
		menu_editar_item.set_submenu ( menu_editar );

		var menu_preferencias = new Gtk.MenuItem.with_mnemonic ( _("Preferences") );
		menu_preferencias.activate.connect ( this.menu_preferencias_activate_signal );
		menu_editar.add ( menu_preferencias );

		var menu_ayuda_item = new Gtk.MenuItem.with_mnemonic ( _("Help") );
		menu_barra.add( menu_ayuda_item );
		var menu_ayuda = new Gtk.Menu ();
		menu_ayuda_item.set_submenu ( menu_ayuda );

		var menu_acerca = new Gtk.MenuItem.with_mnemonic ( _("About Nomeolvides") );
		menu_acerca.activate.connect ( this.menu_acerca_activate_signal );
		menu_ayuda.add ( menu_acerca );

		this.main_box.pack_start ( this.toolbar, false, false, 0 );
	#else
		this.set_titlebar ( toolbar );
	#endif
		this.main_box.pack_start ( anios_hechos, true, true, 0 );
		this.main_box.pack_start (linea, true, true, 0);

		this.conectar_seniales ();
	}

	private void conectar_seniales () {
		this.toolbar.add_button.activado.connect ( this.toolbar_add_button_clicked_signal );
		this.toolbar.undo_button.activado.connect ( this.toolbar_undo_button_clicked_signal );
		this.toolbar.redo_button.activado.connect ( this.toolbar_redo_button_clicked_signal );
		this.toolbar.edit_button.activado.connect ( this.toolbar_edit_button_clicked_signal );
		this.toolbar.delete_button.activado.connect ( this.toolbar_delete_button_clicked_signal );
		this.toolbar.send_button.activado.connect ( this.toolbar_send_button_clicked_signal );
		this.anios_hechos.anios_cursor_changed.connect ( this.anios_hechos_anios_cursor_changed_signal );
		this.anios_hechos.listas_cursor_changed.connect ( this.anios_hechos_listas_cursor_changed_signal );
		this.anios_hechos.hechos_selection_changed.connect ( this.elegir_hecho );
	}

	private void toolbar_add_button_clicked_signal () {
		this.toolbar_add_button_clicked ();
	}

	private void toolbar_undo_button_clicked_signal () {
		this.toolbar_undo_button_clicked ();
	}

	private void toolbar_redo_button_clicked_signal () {
		this.toolbar_redo_button_clicked ();
	}

	private void toolbar_edit_button_clicked_signal () {
		this.toolbar_edit_button_clicked ();
	}

	private void toolbar_delete_button_clicked_signal () {
		this.toolbar_delete_button_clicked ();
	}

	private void toolbar_send_button_clicked_signal () {
		this.toolbar_send_button_clicked ();
	}

	private void toolbar_list_button_agregar_clicked_signal () {
		this.toolbar_list_agregar_button_clicked ();
	}

	private void toolbar_list_button_quitar_clicked_signal () {
		this.toolbar_list_quitar_button_clicked ();
	}

	private void anios_hechos_anios_cursor_changed_signal () {
		this.anio_actual = this.anios_hechos.get_anio_actual ();
		if ( this.anio_actual != 0 ) {
			this.toolbar.list_button_set_agregar ();
			this.toolbar.list_button.activado.disconnect (this.toolbar_list_button_quitar_clicked_signal);
			this.toolbar.list_button.activado.disconnect (this.toolbar_list_button_agregar_clicked_signal);
			this.toolbar.list_button.activado.connect ( this.toolbar_list_button_agregar_clicked_signal );
			this.anios_hechos_anios_cursor_changed ();
		}
		
		this.actualizar_anio_label ();
	}

	private void anios_hechos_listas_cursor_changed_signal () {
		this.lista_actual = this.anios_hechos.get_lista_actual ();
		if (this.lista_actual != null ) {
			this.toolbar.list_button_set_quitar ();
			this.toolbar.list_button.activado.disconnect (this.toolbar_list_button_quitar_clicked_signal);
			this.toolbar.list_button.activado.disconnect (this.toolbar_list_button_agregar_clicked_signal);
			this.toolbar.list_button.activado.connect ( this.toolbar_list_button_quitar_clicked_signal );
			this.anios_hechos_listas_cursor_changed ();
		}

		this.actualizar_lista_label ();
	}

	public void cargar_anios_view ( Array<int> ventana_principal_anios ) {
		this.anios_hechos.cargar_lista_anios ( ventana_principal_anios );
		this.actualizar_anio_label ();
	}

	public void cargar_listas_view ( ListStoreListas listas ) {
		this.anios_hechos.cargar_listas ( listas );
		this.anios_hechos.mostrar_scroll_vista ( false );
		this.actualizar_lista_label ();
	}

	public void cargar_hechos_view ( Array<Hecho> hechos ) {
		this.anios_hechos.cargar_lista_hechos ( hechos );
		this.anios_hechos.mostrar_scroll_vista ( false );
	}

	private void actualizar_anio_label () {
		if ( this.anio_actual != 0) {
			this.toolbar.set_label_anio ( this.anio_actual.to_string() );
		} else {
			this.toolbar.set_label_anio ( );

		}
	}

	private void actualizar_lista_label () {
		if ( this.lista_actual != null ) {
			this.toolbar.set_label_lista ( this.lista_actual.nombre );
		} else {
			this.toolbar.set_label_lista ( );
		}	
	}

	public int get_anio_actual () {
		return this.anio_actual;
	}

	public Lista get_lista_actual () {
		return this.lista_actual;
	}

	public TreePath get_hecho_actual ( out Hecho hecho ) {
		return this.anios_hechos.get_hecho_actual (out hecho );
	}

	public Array<Hecho> get_hechos_seleccionados () {
		return this.anios_hechos.get_hechos_seleccionados ();
	}

	private void elegir_hecho () {
		Hecho hecho; 
		this.get_hecho_actual ( out hecho );
		
		if ( hecho != null ) {
			if ( this.get_hechos_seleccionados ().length == 1 ) {
				this.toolbar.set_buttons_visible ();
			} else {
				if ( this.get_hechos_seleccionados ().length > 0 ) {
					this.toolbar.set_buttons_multiseleccion_visible ();
				} else {
					this.toolbar.set_buttons_invisible ();
				}
			}
		} else {
			this.toolbar.set_buttons_invisible ();		
		}
	}

	public void cargar_linea_de_tiempo (Array<Hecho> hechos) {
		this.linea.set_hechos ( hechos );
	}

	public void show_visible () {
		this.show_all ();
		this.anios_hechos.mostrar_scroll_vista ( false );
	}

	public string get_pestania () {
		return this.anios_hechos.get_nombre_pestania ();
	}

	public void activar_boton_deshacer () {
		this.toolbar.activar_deshacer ();
	}

	public void desactivar_boton_deshacer () {
		this.toolbar.desactivar_deshacer ();
	}

	public void activar_boton_rehacer () {
		this.toolbar.activar_rehacer ();
	}

	public void desactivar_boton_rehacer () {
		this.toolbar.desactivar_rehacer ();
	}

	public void limpiar_hechos_view () {
		this.anios_hechos.limpiar_hechos_view ();
	}

#if DISABLE_GNOME3
	public void menu_exportar_activate_signal () {
		this.menu_exportar_activate ();
	}

	public void menu_importar_activate_signal () {
		this.menu_importar_activate ();
	}

	public void menu_salir_activate_signal () {
		this.menu_salir_activate ();
	}

	public void menu_preferencias_activate_signal () {
		this.menu_preferencias_activate ();
	}

	public void menu_acerca_activate_signal () {
		this.menu_acerca_activate ();
	}

#endif
	public signal void toolbar_add_button_clicked ();
	public signal void toolbar_undo_button_clicked ();
	public signal void toolbar_redo_button_clicked ();
	public signal void toolbar_edit_button_clicked ();
	public signal void toolbar_delete_button_clicked ();
	public signal void toolbar_send_button_clicked ();
	public signal void toolbar_list_quitar_button_clicked ();
	public signal void toolbar_list_agregar_button_clicked ();
	public signal void anios_hechos_anios_cursor_changed ();
	public signal void anios_hechos_listas_cursor_changed ();
#if DISABLE_GNOME3
	public signal void menu_exportar_activate ();
	public signal void menu_importar_activate ();
	public signal void menu_salir_activate ();
	public signal void menu_preferencias_activate ();
	public signal void menu_acerca_activate ();
#endif
}
