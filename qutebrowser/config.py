# pylint: disable=C0111
from qutebrowser.config.configfiles import ConfigAPI  # noqa: F401
from qutebrowser.config.config import ConfigContainer  # noqa: F401

config: ConfigAPI = config  # noqa: F821 pylint: disable=E0602,C0103
c: ConfigContainer = c  # noqa: F821 pylint: disable=E0602,C0103

config.load_autoconfig(False)

config.set('content.cookies.accept', 'all', 'devtools://*')
config.set('content.headers.accept_language', '', 'https://matchmaker.krunker.io/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}', 'https://web.whatsapp.com/')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:90.0) Gecko/20100101 Firefox/90.0', 'https://accounts.google.com/*')
config.set('content.images', True, 'chrome-devtools://*')
config.set('content.images', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome-devtools://*')
config.set('content.javascript.enabled', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'qute://*/*')
config.set('content.local_content_can_access_remote_urls', True, 'file:///home/gordo/.local/share/qutebrowser/userscripts/*')
config.set('content.local_content_can_access_file_urls', False, 'file:///home/gordo/.local/share/qutebrowser/userscripts/*')

c.tabs.show = 'never'
c.tabs.select_on_remove = 'last-used'
c.tabs.last_close = 'close'

c.input.insert_mode.auto_enter = False
c.input.insert_mode.auto_leave = False

c.scrolling.bar = 'never'

c.editor.command = ['foot', '-e', 'nvim', '{file}', '-c', 'normal {line}G{column0}l']

c.fileselect.handler = 'external'
c.fileselect.folder.command = ['foot', '-e', 'zsh', '-c', 'realpath $(find . -type -d | fzf) > {}']
c.fileselect.multiple_files.command = ['foot', '-e', 'zsh', '-c', 'realpath $(fzf -m) > {}']
c.fileselect.single_file.command = ['foot', '-e', 'zsh', '-c', 'realpath $(fzf) > {}']

c.fonts.default_size = '10pt'
c.fonts.default_family = 'Geist'
c.fonts.hints = "bold 11px 'Geist Mono NF'"
c.fonts.keyhint = "bold 13px 'Geist Mono NF'"

c.url.searchengines['DEFAULT'] = 'https://google.com/search?q={}'
c.url.searchengines['pw'] = 'https://proofwiki.org?search={}'
c.url.searchengines['wiki'] = 'https://en.wikipedia.org/wiki/Special:Search/{}'
c.url.searchengines['j'] = 'https://jisho.org/search/{}'

c.downloads.position = 'bottom'
c.downloads.open_dispatcher = 'zathura'
c.downloads.location.directory = '/home/gordo/downloads'
c.downloads.location.prompt = False

c.url.default_page = 'about:blank'
c.url.start_pages = 'about:blank'

c.completion.height = '25%'
c.completion.open_categories = [ 'quickmarks', 'bookmarks', 'history' ]

c.statusbar.widgets = [ 'search_match', 'url', 'progress' ]

config.bind('gp', 'tab-focus stack-prev')
config.bind('gn', 'tab-focus stack-next')
config.bind('gl', 'tab-focus last')

config.bind('zl', 'spawn --userscript qute-pass -n -d bemenu -U secret -u "username: (.+)"')
config.bind("zul", 'spawn --userscript qute-pass -n -d bemenu -U secret -u "username: (.+)" --username-only')
config.bind("zpl", "spawn --userscript qute-pass -n -d bemenu --password-only")

config.bind('xc', ':open https://chatgpt.com')
config.bind('xt', ':open https://tasks.google.com')
config.bind('xy', ':open https://www.youtube.com')
config.bind('xa', ':open https://acorn.utoronto.ca')
config.bind('xq', ':open https://q.utoronto.ca')
config.bind('xm', ':open https://mail.utoronto.ca')
config.bind('xg', ':open https://mail.google.com')
config.bind('xr', ':open https://www.reddit.com')

config.bind('xC', ':open --tab https://chatgpt.com')
config.bind('xT', ':open --tab https://tasks.google.com')
config.bind('xY', ':open --tab https://www.youtube.com')
config.bind('xA', ':open --tab https://acorn.utoronto.ca')
config.bind('xQ', ':open --tab https://q.utoronto.ca')
config.bind('xM', ':open --tab https://mail.utoronto.ca')
config.bind('xG', ':open --tab https://mail.google.com')
config.bind('xR', ':open --tab https://www.reddit.com')

config.bind('ey', ':cmd-set-text :tab-focus https://www.youtube.com')
config.bind('ec', ':cmd-set-text :tab-focus https://chatgpt.com')

config.source('colour.py')
