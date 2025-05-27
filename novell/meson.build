feature = get_option('novell')

summary({'Novell': feature}, section : 'Protocols')

if not feature.allowed()
  subdir_done()
endif

novell_prpl = shared_library('novell',
  'nmconference.c',
  'nmconn.c',
  'nmcontact.c',
  'nmevent.c',
  'nmfield.c',
  'nmmessage.c',
  'nmrequest.c',
  'nmrtf.c',
  'nmuser.c',
  'nmuserrecord.c',
  'novell.c',
  include_directories: toplevel_inc,
  dependencies: [libpurple_dep, glib_dep, ws2_32_dep],
  install: true,
  install_dir: plugin_dir,
)

subdir('pixmaps')
