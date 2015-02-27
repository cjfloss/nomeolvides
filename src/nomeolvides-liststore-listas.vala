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

public class Nomeolvides.ListStoreListas : ListStoreBase {
	private Array<Lista> listas;
	public ListStoreListas () {
		Type[] tipos= { typeof(string), typeof(int), typeof(Base) };
		base ( tipos );
		this.listas = new Array<Lista> ();
	}

	public new void agregar_de_array ( Lista nuevo ) {
		if ( !(this.ya_agregado ( nuevo ) )) {
			this.append(out iterador);
			this.set(iterador, 0, nuevo.nombre, 1, 0, 2, nuevo ); //en cantidad de hechos pongo 0 porque con este método no se vana  mostrar
		}
	}

	public void agregar_varios ( Array<Lista> nuevos ) {
		if ( nuevos.length > 0 ) {
			for ( int i = 0; i < nuevos.length; i++ ) {
				this.agregar_de_array ( nuevos.index (i));
				this.listas.append_val ( nuevos.index (i) );
			}

			this.listas = new Array<Lista> ();
			for ( int i = 0; i < nuevos.length; i++ ) {
				this.listas.append_val ( nuevos.index (i) );
			}

			this.eliminar_sobrantes ();
		} else {
			this.clear ();
			this.listas = new Array<Lista> ();
		}
	}

	public bool ya_agregado ( Lista nuevo ) {
		bool resultado = false;

		for (int i = 0; i < this.listas.length; i++ ) {
			if ( this.listas.index (i).get_checksum () == nuevo.get_checksum () ) {;
				resultado = true;
				break;
			}
		}

		return resultado;
	}

	public bool sobra ( Lista sobrante ) {
		bool de_mas = true;
		int i = 0;

		for ( i = 0; i < listas.length; i++ ) {
			if ( this.listas.index (i).get_checksum () == sobrante.get_checksum () ) {
				de_mas = false;
				break;
			}
		}

		return de_mas;
	}

	private void eliminar_sobrantes () {
		TreeIter iter;
		Value value_lista;
		Lista lista;
		bool flag = true;

		this.get_iter_first ( out iter );

		do {
			this.get_value ( iter, 2, out value_lista );
			lista = value_lista as Lista;

			if ( this.sobra ( lista )) {
				this.remove (iter);
				flag = this.get_iter_first ( out iter );
			} else {
				flag = this.iter_next ( ref iter );
			}
		} while ( flag );
	}
}
