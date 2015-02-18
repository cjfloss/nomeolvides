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

public class Nomeolvides.ListStoreBase : ListStore {
	protected TreeIter iterador;
	protected Array<Base> elementos;
	public bool vacio { get; private set; }
	
	public ListStoreBase ( Type[] tipos = { typeof(string), typeof(int), typeof(Base) } ) {
		this.set_column_types(tipos);
		this.vacio = true;
		this.elementos = new Array<Base> ();
	}

	public void agregar ( Base elemento, int cantidad_hechos = 0 ) {
		if (elemento != null && !this.ya_agregado (elemento) ) {
			this.append ( out this.iterador );
			this.set ( this.iterador,
						0,elemento.nombre,
						1,cantidad_hechos,
						2,elemento );
			this.vacio = false;
			this.elementos.append_val ( elemento );
		}
	}

	public bool ya_agregado ( Base nuevo ) {
		bool resultado = false;

		for (int i = 0; i < this.elementos.length; i++ ) {
			if ( this.elementos.index (i).get_checksum () == nuevo.get_checksum () ) {;
				resultado = true;
				break;
			}
		}

		return resultado;
	}

	public bool sobra ( Base sobrante ) {
		bool de_mas = true;
		int i = 0;

		for ( i = 0; i < this.elementos.length; i++ ) {
			if ( this.elementos.index (i).get_checksum () == sobrante.get_checksum () ) {
				de_mas = false;
				break;
			}
		}

		return de_mas;
	}

	private void eliminar_sobrantes ( ) {
		TreeIter iter;
		Value value_elemento;
		Base elemento;
		bool flag = true;

		this.get_iter_first ( out iter );

		do {
			this.get_value ( iter, 2, out value_elemento );
			elemento = (Base) value_elemento;

			if ( this.sobra ( elemento )) {
				this.remove (iter);
				flag = this.get_iter_first ( out iter );
			} else {
				flag = this.iter_next ( ref iter );
			}
		} while ( flag );
	}

	public void agregar_varios ( Array<Base> nuevos ) {
		if ( nuevos.length > 0 ) {
			for ( int i = 0; i < nuevos.length; i++ ) {
				this.agregar ( nuevos.index (i));
				elementos.append_val ( nuevos.index (i) );
			}

			this.elementos = new Array<Base> ();
			for ( int i = 0; i < nuevos.length; i++ ) {
				this.elementos.append_val ( nuevos.index (i) );
			}

			if ( !this.vacio ) {
				this.eliminar_sobrantes ();
			}

		} else {
			this.clear ();
			this.elementos = new Array<Base> ();
		}
	}

	public string a_json () {
		string json = "";
		Base elemento;
		Value value_elemento;
		TreeIter iter;

		if ( this.get_iter_first( out iter ) ) {
			do {
				this.get_value(iter, 2, out value_elemento);
				elemento = value_elemento as Base;
				json += elemento.a_json ()  + "\n";
			}while (this.iter_next(ref iter));
		}
		return json;
	}

	public void borrar ( Base a_eliminar ) {
		Value elemento_value;
		Base elemento;
		TreeIter iter;
		
		if ( this.get_iter_first( out iter ) ) {
			do {
				this.get_value(iter, 2, out elemento_value);
				elemento = elemento_value as Base;
				if ( a_eliminar.hash == elemento.hash ) {
					this.remove ( iter );
					break;
				}
			}while (this.iter_next(ref iter));
		}

		if ( !( this.get_iter_first( out iter ) ) ) {
			this.vacio = true;
		}
	}

	public int get_hechos ( TreeIter iter ) {
		Value value_cantidad;
		int cantidad = 0;

		this.get_value( iter, 1, out value_cantidad );

		cantidad = (int) value_cantidad;

		return cantidad;
	}

	public int indice_de_id ( int64 id ) {
		Value elemento_value;
		Base elemento;
		TreeIter iter;
		int i=0;

		if ( this.get_iter_first( out iter ) ) {
			do {
				this.get_value(iter, 2, out elemento_value );
				elemento = elemento_value as Base;
				if ( id ==  elemento.id ) {
					break;
				}
				i++;
			} while ( this.iter_next(ref iter) );
		}

		return i;
	}
}
