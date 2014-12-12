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

[GtkTemplate ( ui = "/ar/com/softwareperonista/nomeolvides-git/nomeolvides-stack-hechos-dialog.ui" )]
public class Nomeolvides.StackHechosDialog : Gtk.Stack {
	[GtkChild]
  private TreeViewHechos treeview_muchos_hechos;
    [GtkChild]
  private Label label_hecho;
  
  public void set_label_un_hecho ( string  nombre_hecho ){
    this.label_hecho.set_label ( nombre_hecho );
  }

  public void set_treeview_muchos_hechos ( Array<Hecho> hechos_elegidos ) {
      this.treeview_muchos_hechos.set_margin_bottom ( 10 );
      this.treeview_muchos_hechos.mostrar_hechos ( hechos_elegidos );
      this.set_size_request ( 110, 150 );
  }
}