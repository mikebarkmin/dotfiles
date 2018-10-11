# isort:skip_file
# This example is contributed by Martin Enlund

import os
import urllib

import gi
gi.require_version('GConf', '2.0')
from gi.repository import GConf, GObject, Nautilus


class OpenUrxvtExtension(Nautilus.MenuProvider, GObject.GObject):
    def __init__(self):
        self.client = GConf.Client.get_default()

    def _open_urxvt(self, file):
        filename = urllib.unquote(file.get_uri()[7:])

        if file.is_directory():
            os.chdir(filename)
        else:
            os.chdir(os.path.dirname(filename))

        os.system('/usr/bin/urxvt &')

    def menu_activate_cb(self, menu, file):
        self._open_urxvt(file)

    def menu_background_activate_cb(self, menu, file):
        self._open_urxvt(file)

    def get_file_items(self, window, files):
        if len(files) != 1:
            return

        file = files[0]
        if not file.is_directory() or file.get_uri_scheme() != 'file':
            return

        item = Nautilus.MenuItem(
            name='NautilusPython::openurxvt_file_item',
            label='Open Urxvt',
            tip='Open Urxvt In %s' % file.get_name())
        item.connect('activate', self.menu_activate_cb, file)
        return item,

    def get_background_items(self, window, file):
        item = Nautilus.MenuItem(
            name='NautilusPython::openurxvt_item',
            label='Open Urxvt Here',
            tip='Open Urxvt In This Directory')
        item.connect('activate', self.menu_background_activate_cb, file)
        return item,
