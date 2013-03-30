/* -*- Mode: vala; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*-  */
/* nomeolvides
 *
 * Copyright (C) 2013 Fernando Fernandez <berel@pulqui>
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

using Nomeolvides;
using GLib;
using Gtk;
using Gee;

public class Nomeolvides.DescripcionHecho : Box {

	private ArrayList<Label> parrafos;

	public DescripcionHecho ( ) {

		this.parrafos = new ArrayList<Label> ();
		this.set_orientation ( Orientation.VERTICAL );
		this.set_spacing ( 10 );
		
	}

	public void agregar_texto ( string texto ) {

		int i = 1;
		Label nuevo;
		string parrafo;
		string[] separado = {};

		this.parrafos.clear (); 

		separado = texto.split("/n");

		foreach ( string s in separado ) {
			stdout.printf ("%s", s);
			nuevo = new Label.with_mnemonic ("");
			nuevo.set_width_chars ( 30 );
			nuevo.set_markup ("<span>"+ s +"</span>");
			this.parrafos.add (nuevo);
		}
		
		this.mostrar();
		
	}

	private void mostrar () {

		int i;

		foreach ( Label parrafo in this.parrafos ) {
			this.pack_start (parrafo);
		}
		this.show_all ();
	}

}

