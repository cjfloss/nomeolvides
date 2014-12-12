/* -*- Mode: vala; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*-  */
/* nomeolvides
 *
 * Copyright (C) 2012 Fernando <fernando@softwareperonista.com.ar>
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

[GtkTemplate ( ui = "/ar/com/softwareperonista/nomeolvides-git/nomeolvides-treeview-anios.ui" )]
public class Nomeolvides.TreeViewAnios : TreeView {
	private ListStoreAnios lista;

	construct {
		this.lista = new ListStoreAnios ();
		this.set_model (this.lista);
	}

	public void agregar_varios ( Array<int> nuevos ) {
		this.lista.agregar_varios ( nuevos );
	}

	public int get_anio () {
		TreePath path;
		TreeViewColumn columna;
		TreeIter iterador;
		Value valor;
		
		this.get_cursor(out path, out columna);
		if (path != null ) {
			this.lista.get_iter(out iterador, path);
			this.lista.get_value (iterador, 0, out valor);
			return (int)valor;
		} else { 
			return 0; //retorna el número mágico 0. No existe el año 0, por lo tanto, no hay año elegido.
		}
	}
}
