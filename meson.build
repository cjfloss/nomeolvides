project('nomeolvides',
        ['c', 'vala'],
        version: '0.15.0',
        meson_version: '>= 0.40.0',
)

add_project_arguments('-DGETTEXT_PACKAGE="nomeolvides"', language:'c')

i18n = import('i18n')

gtk3 = dependency('gtk+-3.0', version: '>= 3.22')
sqlite = dependency('sqlite3', version: '>= 3.0')

deps = [
  gtk3,
  sqlite,
]

gnome = import('gnome')

#subdir('data')
subdir('icon')
subdir('config')
subdir('ui')
subdir('src')
#subdir('po')