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

[GtkTemplate ( ui = "/ar/com/softwareperonista/nomeolvides-git/nomeolvides-selector-fecha.ui" )]
public class Nomeolvides.SelectorFecha : Grid {
  [GtkChild]
	private SpinButton spinbutton_dia;
	[GtkChild]
	private ComboBox combobox_mes;
	[GtkChild]
	private SpinButton spinbutton_anio;

	public SelectorFecha () {}

  [GtkCallback]
	private void set_dias_del_mes () {
		int mes = this.get_mes ();

		if (mes == 1 || mes == 3 || mes == 5 || mes == 7 || mes == 8 || mes == 10 || mes == 12) {
			this.spinbutton_dia.get_adjustment().set_upper ( 31 );
		} else if ( mes == 4 || mes == 6 || mes == 9 || mes == 11 ) {
			if ( this.get_dia () >= 31 ) {
				this.spinbutton_dia.set_value (30);
			}
		} else {
			GLib.DateYear anio = (GLib.DateYear)this.get_anio ();
			if ( anio.is_leap_year() ) {
				this.spinbutton_dia.get_adjustment().set_upper ( 29 );
				if ( this.get_dia () >= 30 ) {
					this.spinbutton_dia.set_value (29);
				}
			} else {
				this.spinbutton_dia.get_adjustment().set_upper ( 28 );
				if ( this.get_dia () >= 29 ) {
					this.spinbutton_dia.set_value (28);
				}
			}
		}
		this.show_all ();
	}

[GtkCallback]
	private void cambiar_anio () {
		GLib.DateYear anio = (GLib.DateYear)this.get_anio ();
		if ( anio.is_leap_year() && this.get_mes () == 2 ) {
			this.spinbutton_dia.get_adjustment().set_upper ( 29 );
		} else {
			if ( this.get_mes () == 2 && this.get_dia () >= 29 ) {
				this.spinbutton_dia.set_value (28);
			}	
		}
		this.show_all ();
	}

	public int get_dia () {
		return (int) this.spinbutton_dia.get_value ();
	}

	public int get_mes () {
		TreeIter iter;
		Value mes;

		this.combobox_mes.get_active_iter( out iter );
		this.combobox_mes.get_model ().get_value (iter, 1, out mes);

		return (int) mes ;
	}

	public int get_anio () {
		return (int) this.spinbutton_anio.get_value ();
	}

	public void set_dia ( int valor ) {
		this.spinbutton_dia.set_value ( valor );
	}

	public void set_mes ( int valor ) {
		this.combobox_mes.set_active ( valor-1 );
	}

	public void set_anio ( int valor ) {
		this.spinbutton_anio.set_value ( valor );
	}
}
