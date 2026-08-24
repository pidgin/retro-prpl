if host_machine.system() != 'windows'
  subdir_done()
endif

makensis_exe = find_program('makensis')

win32_installer_version = meson.project_version()

win32_installer = custom_target(
  'win32-installer',
  command : [
    makensis_exe,
    '-V3',
    '-DBUILD_ROOT=@0@'.format(meson.project_build_root()),
    '-DPIDGIN_VERSION=@0@'.format(libpurple_dep.version()),
    '-DRETRO_PRPL_VERSION=@0@'.format(meson.project_version()),
    '-DSOURCE_DIR=@0@'.format(meson.current_source_dir()),
    '-DSOURCE_ROOT=@0@'.format(meson.project_source_root()),
    '@INPUT@',
  ],
  input : 'retro-prpl-installer.nsi',
  depends : built_plugins,
  output : f'retro-prpl-@win32_installer_version@.exe')

alias_target('win32-installer', win32_installer)
