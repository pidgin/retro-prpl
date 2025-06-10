project('retro-prpl', 'c', meson_version : '>=1.0.0', version : '2025-06-10-88b361b8f718485ae19185213b909d57a33236a6')

add_project_arguments('-DHAVE_CONFIG_H', '-DPURPLE_PLUGINS', language: 'c')

cc = meson.get_compiler('c')

glib_dep = dependency('glib-2.0', version: '>= 2.16.0')
libpurple_dep = dependency('purple', version: '>= 2.14.0')

cfg = configuration_data()
cfg.set_quoted('DISPLAY_VERSION', meson.project_version())
cfg.set_quoted('GETTEXT_PACKAGE', meson.project_name())
cfg.set_quoted('PACKAGE', meson.project_name())
cfg.set_quoted('PACKAGE_NAME', meson.project_name())
cfg.set_quoted('PACKAGE_VERSION', meson.project_version())
cfg.set_quoted('VERSION', meson.project_version())

cfg.set('SIZEOF_TIME_T',
        cc.sizeof('time_t',
                  prefix: ['#include <stdio.h>', '#include <time.h>']),
        description: 'Size of time_t struct')

toplevel_inc = include_directories('.')

if get_option('use-purple-prefix')
  pixmap_dir = libpurple_dep.get_variable('datadir') / 'pixmaps/pidgin'
  plugin_dir = libpurple_dep.get_variable('plugindir')
else
  pixmap_dir = get_option('prefix') / get_option('datadir') / 'pixmaps/pidgin'
  plugin_dir = get_option('prefix') / get_option('libdir') / 'purple-2'
endif

if host_machine.system() == 'windows'
  ws2_32_dep = cc.find_library('ws2_32')
else
  ws2_32_dep = []
endif

plugin_suffix = []
if host_machine.system() == 'darwin'
  plugin_suffix = 'so'
endif

summary({
  'plugins': plugin_dir,
  'pixmaps': pixmap_dir,
  },
  section : 'Install Directories')

subdir('gg')
subdir('msn')
subdir('mxit')
subdir('myspace')
subdir('napster')
subdir('novell')
subdir('oscar')
subdir('qq')
subdir('sametime')
subdir('silc')
subdir('silc10')
subdir('toc')
subdir('yahoo')
subdir('zephyr')

configure_file(output: 'config.h', configuration: cfg)
