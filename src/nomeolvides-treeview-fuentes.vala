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

public class Nomeolvides.TreeViewFuentes : TreeView {
	public TreeViewFuentes () {
		this.insert_column_with_attributes ( -1, "Nombre", new CellRendererText(), "text", 0 );
		this.insert_column_with_attributes ( -1, "Nombre de Archivo", new CellRendererText(), "text", 1 );
		this.insert_column_with_attributes ( -1, "Dirección", new CellRendererText(), "text", 2 );
		this.insert_column_with_attributes ( -1, "Tipo de Fuente", new CellRendererText(), "text", 3 );

	}
}