libyahoo = static_library('yahoo',
  'libymsg.c',
  'util.c',
  'yahoo_aliases.c',
  'yahoochat.c',
  'yahoo_doodle.c',
  'yahoo_filexfer.c',
  'yahoo_friend.c',
  'yahoo_packet.c',
  'yahoo_picture.c',
  'yahoo_profile.c',
  'ycht.c',
  include_directories: toplevel_inc,
  dependencies: [libpurple_dep, glib_dep, ws2_32_dep],
)

feature = get_option('yahoo')
summary({'Yahoo!': feature.allowed()}, bool_yn : true, section : 'Protocols')
if feature.allowed()
  yahoo_prpl = shared_library('retroyahoo',
    'libyahoo.c',
    include_directories: toplevel_inc,
    dependencies: [libpurple_dep, glib_dep, ws2_32_dep],
    link_with: libyahoo,
    name_suffix: plugin_suffix,
    install: true,
    install_dir: plugin_dir,
  )
endif

feature = get_option('yahoojp')
summary({'Yahoo! Japan': feature.allowed()}, bool_yn : true, section : 'Protocols')
if feature.allowed()
  yahoojp_prpl = shared_library('retroyahoojp',
    'libyahoojp.c',
    include_directories: toplevel_inc,
    dependencies: [libpurple_dep, glib_dep, ws2_32_dep],
    link_with: libyahoo,
    name_suffix: plugin_suffix,
    install: true,
    install_dir: plugin_dir,
  )
endif

subdir('pixmaps')
