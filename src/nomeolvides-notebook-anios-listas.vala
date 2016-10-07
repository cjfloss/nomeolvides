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

[GtkTemplate ( ui = "/ar/com/softwareperonista/nomeolvides/nomeolvides-notebook-anios-listas.ui" )]
public class Nomeolvides.NotebookAniosListas : Gtk.Notebook {
	[GtkChild]
  public TreeViewBase treeview_listas;
  [GtkChild]
  public TreeViewAnios treeview_anios;

  construct {
    this.treeview_listas.no_mostrar_treeviewcolumn_base_cantidad_hechos ();
  }
}