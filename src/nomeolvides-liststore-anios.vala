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

public class Nomeolvides.ListStoreAnios : Gtk.ListStore {
	private TreeIter iterador;
	private Array<int> anios;
	
	public ListStoreAnios () {		
		Type[] tipos= { typeof (int) };
		this.set_column_types(tipos);
		this.anios = new Array<int>();
		this.set_sort_column_id(0, SortType.ASCENDING);
		this.set_sort_func(2, ordenar_anios);
	}

	public void agregar ( int nuevo ) {
		if ( !(this.ya_agregado ( nuevo ) )) {
			this.append(out iterador);
			this.set(iterador, 0, nuevo );
		}
	}

	public void agregar_varios ( Array<int> nuevos ) {
		if ( nuevos.length > 0 ) {
			for ( int i = 0; i < nuevos.length; i++ ) {
				this.agregar ( nuevos.index (i));
				anios.append_val ( nuevos.index (i) );
			}

			this.anios = new Array<int> ();
			for ( int i = 0; i < nuevos.length; i++ ) {
				this.anios.append_val ( nuevos.index (i) );
			}

			this.eliminar_sobrantes ();
		} else {
			this.clear ();
			this.anios = new Array<int> ();
		}
	}

	public bool ya_agregado ( int nuevo ) {
		bool resultado = false;

		for (int i = 0; i < this.anios.length; i++ ) {
			if ( this.anios.index (i) == nuevo ) {;
				resultado = true;
				break;
			}
		}

		return resultado;
	}

	public bool sobra ( int sobrante ) {
		bool de_mas = true;
		int i = 0;

		for ( i = 0; i < anios.length; i++ ) {
			if ( this.anios.index (i) == sobrante ) {
				de_mas = false;
				break;
			}
		}

		return de_mas;
	}

	private void eliminar_sobrantes ( ) {
		TreeIter iter;
		Value value_anio;
		int anio;
		bool flag = true;

		this.get_iter_first ( out iter );

		do {
			this.get_value ( iter, 0, out value_anio );
			anio = (int) value_anio;

			if ( this.sobra ( anio )) {
				this.remove (iter);
				flag = this.get_iter_first ( out iter );
			} else {
				flag = this.iter_next ( ref iter );
			}
		} while ( flag );
	}

		private int ordenar_anios (Gtk.TreeModel model2, Gtk.TreeIter iter1, Gtk.TreeIter iter2) {
		GLib.Value val1;
		GLib.Value val2;

		int anio1;
		int anio2;

		this.get_value(iter1, 0, out val1);
		this.get_value(iter2, 0, out val2);

		anio1 = (int) val1;
		anio2 = (int) val2;

		if (anio1 < anio2) {
			return -1;
		} else {
			if (anio1 > anio2) {
				return 1;
			} else {
				return 0;
			}
		}
	}
}
