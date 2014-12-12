/* -*- Mode: vala; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*-  */
/* Nomeolvides
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

[GtkTemplate ( ui = "/ar/com/softwareperonista/nomeolvides-git/nomeolvides-dialog-hecho-borrar.ui" ) ]
public class Nomeolvides.DialogHechoBorrar : Dialog {
	[GtkChild]
	private StackHechosDialog stack_hechos;
	[GtkChild]
	private Label label_pregunta;
	[GtkChild]
  private Label label_fecha_pregunta;
	[GtkChild]
  private Label label_hecho_fecha;
	public Array<Hecho> hechos;

	public DialogHechoBorrar ( VentanaPrincipal ventana ) {
		Object (use_header_bar: 1);
		this.set_transient_for ( ventana as Gtk.Window );
		this.hechos = new Array<Hecho> ();
	}

	public void setear_hechos ( Array<Hecho> hechos_elegidos ) {
		if ( hechos_elegidos.length == 1 ) {
			this.stack_hechos.set_label_un_hecho ( hechos_elegidos.index (0).nombre );
			this.label_hecho_fecha.set_label ( hechos_elegidos.index (0).fecha_to_string () );
		} else {
			this.title = _("Remove Facts");
			this.set_size_request ( 600, 200 );
			this.label_hecho_fecha.destroy ();
			this.label_fecha_pregunta.destroy ();
			this.label_pregunta.set_label ( "Do you want to remove these facts?");
			this.stack_hechos.set_treeview_muchos_hechos ( hechos_elegidos );
			this.stack_hechos.set_visible_child_name ( "page_muchos_hechos" );
		}

		for ( int i = 0; i < hechos_elegidos.length; i++ ) {
			this.hechos.append_val ( hechos_elegidos.index ( i ) );
		}

		this.show_all ();
	}

/*	private void set_labels ( Array<Hecho> hechos_elegidos ) {
		if ( hechos_elegidos.length == 1 ) {
			this.set_title ( _("Remove Fact") );
			Label hecho_de = new Label.with_mnemonic ( _("dated") + ":" );
			Label hecho_fecha = new Label.with_mnemonic ( "" );
			Label hecho_nombre = new Label.with_mnemonic ( "" );
			hecho_nombre.set_line_wrap_mode ( Pango.WrapMode.WORD );
			hecho_nombre.set_line_wrap ( true );
			hecho.set_label ( _("Fact") + ":" );
			this.pregunta.set_markup ( "<big>" + _("Do you want to remove this fact?") + "</big>" );
			hecho_nombre.set_markup ( "<span font_weight=\"heavy\">"+ hechos_elegidos.index (0).nombre +"</span>");
			hecho_fecha.set_markup ( "<span font_weight=\"heavy\">"+ hechos_elegidos.index (0).fecha_to_string() +"</span>");

			grid.attach ( hecho_nombre, 1, 1, 1, 1 );
			grid.attach ( hecho_de, 0, 2, 1, 1 );
			grid.attach ( hecho_fecha, 1, 2, 1, 1 );
		} else {
			this.set_title ( _("Remove Facts") );
			this.pregunta.set_markup ( "<big>" + _("Do you want to remove this facts?") + "</big>" );
			this.hecho.set_label ( _("Facts") + ":" );
		}
	}*/
}
