feature = get_option('zephyr')

real_feature = feature.disable_auto_if(host_machine.system() == 'windows')

summary({'Zephyr': real_feature}, section : 'Protocols')

if not real_feature.allowed()
  subdir_done()
endif

foreach header : ['fcntl.h', 'malloc.h', 'paths.h', 'sgtty.h', 'sys/cdefs.h',
                  'sys/file.h', 'sys/filio.h', 'sys/ioctl.h', 'sys/msgbuf.h',
                  'sys/select.h', 'sys/uio.h', 'sys/utsname.h', 'sys/wait.h',
                  'termios.h', 'unistd.h']
  name = header.underscorify().to_upper()
  if cc.check_header(header)
    cfg.set(f'HAVE_@name@', true)
  endif
endforeach

foreach func : ['gethostid', 'inet_ntop', 'lrand48', 'memcpy', 'memmove',
                'random', 'strchr', 'strerror', 'vprintf']
  name = func.underscorify().to_upper()
  if cc.has_function(func)
    cfg.set(f'HAVE_@name@', true)
  endif
endforeach

cfg.set('ZEPHYR_INT32', 'long')

cfg.set_quoted('CONFDIR', get_option('prefix') / get_option('sysconfdir'))

zephyr_prpl = shared_library('zephyr',
  'ZAsyncLocate.c',
  'ZCkAuth.c',
  'ZCkIfNot.c',
  'ZClosePort.c',
  'ZCmpUID.c',
  'ZCmpUIDP.c',
  'ZFlsLocs.c',
  'ZFlsSubs.c',
  'ZFmtAuth.c',
  'ZFmtList.c',
  'ZFmtNotice.c',
  'ZFmtRaw.c',
  'ZFmtRawLst.c',
  'ZFmtSmRaw.c',
  'ZFmtSmRLst.c',
  'ZFreeNot.c',
  'ZGetLocs.c',
  'ZGetSender.c',
  'ZGetSubs.c',
  'ZGetWGPort.c',
  'ZhmStat.c',
  'ZIfNotice.c',
  'ZInit.c',
  'Zinternal.c',
  'ZLocations.c',
  'ZMakeAscii.c',
  'ZMkAuth.c',
  'ZNewLocU.c',
  'ZOpenPort.c',
  'ZParseNot.c',
  'ZPeekIfNot.c',
  'ZPeekNot.c',
  'ZPeekPkt.c',
  'ZPending.c',
  'ZReadAscii.c',
  'ZRecvNot.c',
  'ZRecvPkt.c',
  'ZRetSubs.c',
  'ZSendList.c',
  'ZSendNot.c',
  'ZSendPkt.c',
  'ZSendRaw.c',
  'ZSendRLst.c',
  'ZSetDest.c',
  'ZSetFD.c',
  'ZSetSrv.c',
  'ZSubs.c',
  'ZVariables.c',
  'ZWait4Not.c',
  'error_message.c',
  'et_name.c',
  'init_et.c',
  'zephyr.c',
  'zephyr_err.c',
  include_directories: toplevel_inc,
  dependencies: [libpurple_dep, glib_dep, ws2_32_dep],
  install: true,
  install_dir: plugin_dir,
)

subdir('pixmaps')
