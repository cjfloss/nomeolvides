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

[GtkTemplate ( ui = "/org/softwareperonista/nomeolvides/nomeolvides-ventana-principal.ui" )]
public class Nomeolvides.VentanaPrincipal : Gtk.ApplicationWindow {
	[GtkChild]
	public HeaderBar headerbar;
	[GtkChild]
	public InterfazPrincipal interfaz_principal;
	private int anio_actual;
	private Lista lista_actual;

	public VentanaPrincipal ( Gtk.Application app ) {
		Object (application: app);
		this.headerbar.headerbar_stackswitcher.set_stack ( this.interfaz_principal.stack_principal );
		this.anio_actual = 0;
		this.conectar_seniales ();
	}

	private void conectar_seniales () {
		this.headerbar.boton_agregar.activado.connect ( this.headerbar_boton_agregar_clicked_signal );
		this.headerbar.boton_deshacer.activado.connect ( this.headerbar_boton_deshacer_clicked_signal );
		this.headerbar.boton_rehacer.activado.connect ( this.headerbar_boton_rehacer_clicked_signal );
		this.interfaz_principal.interfaz_fecha.actionbar.boton_editar.activado.connect ( this.headerbar_boton_editar_clicked_signal );
		this.interfaz_principal.interfaz_fecha.actionbar.boton_borrar.activado.connect ( this.headerbar_boton_borrar_clicked_signal );
		this.interfaz_principal.interfaz_fecha.actionbar.boton_enviar.activado.connect ( this.headerbar_boton_enviar_clicked_signal );
		this.interfaz_principal.interfaz_fecha.anios_cursor_changed.connect ( this.interfaz_principal_anios_cursor_changed_signal );
		this.interfaz_principal.interfaz_fecha.listas_cursor_changed.connect ( this.interfaz_principal_listas_cursor_changed_signal );
		this.interfaz_principal.interfaz_fecha.hechos_selection_changed.connect ( this.elegir_hecho );
	}

	private void headerbar_boton_agregar_clicked_signal () {
		this.headerbar_boton_agregar_clicked ();
	}

	private void headerbar_boton_deshacer_clicked_signal () {
		this.headerbar_boton_deshacer_clicked ();
	}

	private void headerbar_boton_rehacer_clicked_signal () {
		this.headerbar_boton_rehacer_clicked ();
	}

	private void headerbar_boton_editar_clicked_signal () {
		this.headerbar_boton_editar_clicked ();
	}

	private void headerbar_boton_borrar_clicked_signal () {
		this.headerbar_boton_borrar_clicked ();
	}

	private void headerbar_boton_enviar_clicked_signal () {
		this.headerbar_boton_enviar_clicked ();
	}

	private void headerbar_boton_agregar_a_lista_agregar_clicked_signal () {
		this.headerbar_boton_agregar_a_lista_agregar_clicked ();
	}

	private void headerbar_boton_agregar_a_lista_quitar_clicked_signal () {
		this.headerbar_boton_agregar_a_lista_quitar_clicked ();
	}

	private void interfaz_principal_anios_cursor_changed_signal () {
		this.anio_actual = this.interfaz_principal.interfaz_fecha.get_anio_actual ();
		if ( this.anio_actual != 0 ) {
			this.interfaz_principal.interfaz_fecha.actionbar.boton_agregar_a_lista_set_agregar ();
			this.interfaz_principal.interfaz_fecha.actionbar.boton_agregar_a_lista.activado.disconnect (this.headerbar_boton_agregar_a_lista_quitar_clicked_signal);
			this.interfaz_principal.interfaz_fecha.actionbar.boton_agregar_a_lista.activado.disconnect (this.headerbar_boton_agregar_a_lista_agregar_clicked_signal);
			this.interfaz_principal.interfaz_fecha.actionbar.boton_agregar_a_lista.activado.connect ( this.headerbar_boton_agregar_a_lista_agregar_clicked_signal );
			this.interfaz_principal_anios_cursor_changed ();
		}
	}

	private void interfaz_principal_listas_cursor_changed_signal () {
/*		this.lista_actual = this.interfaz_principal.interfaz_fecha.get_lista_actual ();
		if (this.lista_actual != null ) {
			this.interfaz_principal.interfaz_fecha.actionbar.boton_agregar_a_lista_set_quitar ();
			this.interfaz_principal.interfaz_fecha.actionbar.boton_agregar_a_lista.activado.disconnect (this.headerbar_boton_agregar_a_lista_quitar_clicked_signal);
			this.interfaz_principal.interfaz_fecha.actionbar.boton_agregar_a_lista.activado.disconnect (this.headerbar_boton_agregar_a_lista_agregar_clicked_signal);
			this.interfaz_principal.interfaz_fecha.actionbar.boton_agregar_a_lista.activado.connect ( this.headerbar_boton_agregar_a_lista_quitar_clicked_signal );
			this.interfaz_principal_listas_cursor_changed ();
		}
*/
	}

	public void cargar_anios_view ( Array<int> ventana_principal_anios ) {
		this.interfaz_principal.interfaz_fecha.cargar_anios ( ventana_principal_anios );
	}

	public void cargar_listas_view ( ListStoreListas listas ) {
//		this.interfaz_principal.cargar_listas ( listas );
//		this.interfaz_principal.mostrar_scroll_vista ( false );
	}

	public void cargar_hechos_view ( Array<Hecho> hechos ) {
		this.interfaz_principal.interfaz_fecha.cargar_hechos ( hechos );
		this.interfaz_principal.interfaz_fecha.mostrar_portada ();
	}

	public int get_anio_actual () {
		return this.anio_actual;
	}

	public Lista get_lista_actual () {
		return this.lista_actual;
	}

	public TreePath get_hecho_actual ( out Hecho hecho ) {
		return this.interfaz_principal.interfaz_fecha.get_hecho_actual (out hecho );
	}

	public Array<Hecho> get_hechos_seleccionados () {
		return this.interfaz_principal.interfaz_fecha.get_hechos_seleccionados ();
	}

	private void elegir_hecho () {
		Hecho hecho;
		this.get_hecho_actual ( out hecho );

		if ( hecho != null ) {
			this.interfaz_principal.interfaz_fecha.mostrar_actionbar ();
		}
	}

	public void show_visible () {
		this.show_all ();
		this.interfaz_principal.interfaz_fecha.mostrar_actionbar ();
		this.interfaz_principal.interfaz_fecha.mostrar_portada ();
	}

	public string get_pestania () {
		return "hola";//this.interfaz_principal.interfaz_fecha.get_nombre_pestania ();
	}

	public void activar_boton_deshacer () {
		this.headerbar.activar_deshacer ();
	}

	public void desactivar_boton_deshacer () {
		this.headerbar.desactivar_deshacer ();
	}

	public void activar_boton_rehacer () {
		this.headerbar.activar_rehacer ();
	}

	public void desactivar_boton_rehacer () {
		this.headerbar.desactivar_rehacer ();
	}

	public void limpiar_hechos_view () {
		this.interfaz_principal.interfaz_fecha.limpiar_treeview_hechos ();
	}

	public signal void headerbar_boton_agregar_clicked ();
	public signal void headerbar_boton_deshacer_clicked ();
	public signal void headerbar_boton_rehacer_clicked ();
	public signal void headerbar_boton_editar_clicked ();
	public signal void headerbar_boton_borrar_clicked ();
	public signal void headerbar_boton_enviar_clicked ();
	public signal void headerbar_boton_agregar_a_lista_quitar_clicked ();
	public signal void headerbar_boton_agregar_a_lista_agregar_clicked ();
	public signal void interfaz_principal_anios_cursor_changed ();
	public signal void interfaz_principal_listas_cursor_changed ();
}

