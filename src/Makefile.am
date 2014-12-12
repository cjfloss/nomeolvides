## Process this file with automake to produce Makefile.in

## Created by Anjuta

bin_PROGRAMS = nomeolvides-git

nomeolvides_git_SOURCES = \
	config.vapi \
	nomeolvides-acciones-db.vala \
	nomeolvides-app.vala \
	nomeolvides-archivo.vala \
	nomeolvides-base-de-datos.vala \
	nomeolvides-base.vala \
	nomeolvides-boton.vala \
	nomeolvides-coleccion.vala \
	nomeolvides-configuracion.vala \
	nomeolvides-datos.vala \
	nomeolvides-deshacer-item.vala \
	nomeolvides-deshacer.vala \
	nomeolvides-dialog-archivo-abrir.vala \
	nomeolvides-dialog-archivo-guardar.vala \
	nomeolvides-dialog-coleccion.vala \
	nomeolvides-dialog-hecho-agregar.vala \
	nomeolvides-dialog-hecho-borrar.vala \
	nomeolvides-dialog-hecho-editar.vala \
	nomeolvides-dialog-hecho-lista-agregar.vala \
	nomeolvides-dialog-hecho-lista-borrar.vala \
	nomeolvides-dialog-hechos-importar.vala \
	nomeolvides-dialog-hecho.vala \
	nomeolvides-dialog-lista.vala \
	nomeolvides-dialog-migrador.vala \
	nomeolvides-dialog-preferencias.vala \
	nomeolvides-fecha.vala \
	nomeolvides-hecho.vala \
	nomeolvides-interfaz-principal.vala \
	nomeolvides-lista.vala \
	nomeolvides-liststore-anios.vala \
	nomeolvides-liststore-base.vala \
	nomeolvides-liststore-colecciones.vala \
	nomeolvides-liststore-hechos.vala \
	nomeolvides-liststore-listas.vala \
	nomeolvides-main.vala \
	nomeolvides-portada.vala \
	nomeolvides-preferencias-base.vala \
	nomeolvides-preferencias-colecciones.vala \
	nomeolvides-preferencias-listas.vala \
	nomeolvides-resources.c \
	nomeolvides-selector-fecha.vala \
	nomeolvides-sqlite.vala \
	nomeolvides-toolbar.vala \
	nomeolvides-treeview-anios.vala \
	nomeolvides-treeview-base.vala \
	nomeolvides-treeview-colecciones.vala \
	nomeolvides-treeview-hechos.vala \
	nomeolvides-utiles.vala \
	nomeolvides-ventana-principal.vala \
	nomeolvides-stack-hechos-dialog.vala \
	nomeolvides-headerbar.vala \
	nomeolvides-notebook-anios-listas.vala \
	nomeolvides-popover-base.vala \
	nomeolvides-popover-coleccion-agregar.vala \
	nomeolvides-popover-coleccion-editar.vala \
	nomeolvides-popover-lista-agregar.vala \
	nomeolvides-popover-lista-editar.vala \
	nomeolvides-popover-base-borrar.vala \
	nomeolvides-popover-coleccion-borrar.vala \
	nomeolvides-popover-lista-borrar.vala \
	$(NULL)

nomeolvides-resources.c: nomeolvides.gresource.xml
	$(AM_V_GEN) glib-compile-resources --sourcedir=$(srcdir) --target=$@ --c-name nomeolvides_git --generate-source $<

nomeolvides_git_CFLAGS = \
	-include config.h \
	-DPACKAGE_LOCALE_DIR=\""$(localedir)"\" \
	$(GTK_MODULE_CFLAGS) \
	$(SQLITE_MODULE_CFLAGS) \
	$(NULL)

nomeolvides_git_LDADD = \
	$(GTK_MODULE_LIBS) \
	$(SQLITE_MODULE_LIBS) \
	$(NULL)

nomeolvides_git_LDFLAGS = \
	$(WARN_LDFLAGS) \
	$(NULL)

nomeolvides_git_VALAFLAGS = \
	--thread \
	--target-glib=2.44 \
	--pkg glib-2.0 \
	--pkg gtk+-3.0 \
	--pkg sqlite3 \
	--gresources nomeolvides.gresource.xml \
	$(NULL)

if PLATFORM_WIN32
nomeolvides_git_LDFLAGS += -Wl,--export-all-symbols
else
nomeolvides_git_LDFLAGS += -Wl,--export-dynamic
endif

if NATIVE_WIN32
nomeolvides_git_LDFLAGS += -mwindows
endif

EXTRA_DIST = 	$(ui_DATA) \
		nomeolvides.gresource.xml \
		nomeolvides-app-menu.ui \
		nomeolvides-dialog-hecho-lista-agregar.ui \
		nomeolvides-dialog-hecho-borrar.ui \
		nomeolvides-dialog-hecho.ui \
		nomeolvides-boton.ui \
		nomeolvides-preferencias-base.ui \
		nomeolvides-headerbar.ui \
		nomeolvides-toolbar.ui \
		nomeolvides-portada.ui \
		nomeolvides-interfaz-principal.ui \
		nomeolvides-notebook-anios-listas.ui \
		nomeolvides-dialog-hechos-importar.ui \
		nomeolvides-selector-fecha.ui \
		nomeolvides-treeview-hechos.ui \
		nomeolvides-treeview-base.ui \
		nomeolvides-popover-base.ui \
		nomeolvides-popover-base-borrar.ui \
		nomeolvides-popover-coleccion-agregar.ui \
		nomeolvides-popover-coleccion-editar.ui \
		nomeolvides-popover-lista-agregar.ui \
		nomeolvides-popover-lista-editar.ui \
		nomeolvides-treeview-colecciones.ui \
		nomeolvides-treeview-anios.ui \
		nomeolvides-stack-hechos-dialog.ui \
		nomeolvides-ventana-principal.ui \
		$(NULL)

# Remove ui directory on uninstall
uninstall-local:
	-rm -r $(uidir)
	-rm -r $(pkgdatadir)

CLEANFILES = \
	$(vala_sources:.vala=.c)
clean-local:
	-rm *.c
