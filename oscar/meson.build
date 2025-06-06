liboscar = static_library('oscar',
  'authorization.c',
  'bstream.c',
  'clientlogin.c',
  'encoding.c',
  'family_admin.c',
  'family_alert.c',
  'family_auth.c',
  'family_bart.c',
  'family_bos.c',
  'family_buddy.c',
  'family_chat.c',
  'family_chatnav.c',
  'family_feedbag.c',
  'family_icbm.c',
  'family_icq.c',
  'family_locate.c',
  'family_oservice.c',
  'family_popup.c',
  'family_stats.c',
  'family_userlookup.c',
  'flap_connection.c',
  'kerberos.c',
  'libaim.c',
  'libicq.c',
  'misc.c',
  'msgcookie.c',
  'odc.c',
  'oft.c',
  'oscar.c',
  'oscar_data.c',
  'peer.c',
  'peer_proxy.c',
  'rxhandlers.c',
  'snac.c',
  'tlv.c',
  'userinfo.c',
  'util.c',
  'visibility.c',
  include_directories: toplevel_inc,
  dependencies: [libpurple_dep, glib_dep, ws2_32_dep],
)

feature = get_option('aim')
summary({'AIM': feature.allowed()}, bool_yn : true, section : 'Protocols')
if feature.allowed()
  libaim = shared_library('aim',
    'libaim.c',
    include_directories: toplevel_inc,
    dependencies: [libpurple_dep, glib_dep, ws2_32_dep],
    link_with: liboscar,
    name_suffix: plugin_suffix,
    install: true,
    install_dir: plugin_dir,
  )
endif

feature = get_option('icq')
summary({'ICQ': feature.allowed()}, bool_yn : true, section : 'Protocols')
if feature.allowed()
  libicq = shared_library('icq',
    'libicq.c',
    include_directories: toplevel_inc,
    dependencies: [libpurple_dep, glib_dep, ws2_32_dep],
    link_with: liboscar,
    name_suffix: plugin_suffix,
    install: true,
    install_dir: plugin_dir,
  )
endif

subdir('pixmaps')
