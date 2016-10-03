NULL=

@APPSTREAM_XML_RULES@
appstream_in_files = nomeolvides.appdata.xml.in
appstream_XML = $(appstream_in_files:.xml.in=.xml)

%.appdata.xml: %.appdata.xml.in
	$(AM_V_GEN)$(MSGFMT) --xml --template $< -d $(top_srcdir)/po -o $@

desktopdir = $(datadir)/applications
desktop_in_in_files = nomeolvides.desktop.in.in
desktop_in_files = nomeolvides.desktop.in
desktop_DATA = $(desktop_in_files:.desktop.in=.desktop)

%.desktop: %.desktop.in
	$(AM_V_GEN)$(MSGFMT) --desktop --template $< -d $(top_srcdir)/po -o $@

appicondir=$(datadir)/icons/hicolor/scalable/apps
appicon_DATA=nomeolvides.svg

EXTRA_DIST = \
	     $(desktop_in_files) \
	     $(appicon_DATA) \
	     $(appstream_in_files) \
	     $(NULL)

CLEANFILES = \
	$(desktop_DATA) \
	$(desktop_in_files) \
	$(appdata_DATA) \
	$(NULL)

DISTCLEANFILES = \
	$(desktop_in_files) \
	$(NULL)
