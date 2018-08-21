from i3pystatus import Status
from os.path import expanduser
from i3pystatus.mail.maildir import MaildirMail
from i3pystatus.updates.aptget import AptGet

status = Status()

status.register('clock', format='%d-%m %H:%M')
status.register(
    'pomodoro',
    sound='/usr/share/sounds/sound-icons/pipe.wav',
    pomodoro_duration=45 * 60,
    break_duration=5 * 60,
    long_break_duration=15 * 60
)

# status.register('xkblayout', layouts=['fr bepo', 'fr azerty', 'en qwerty'])
# status.register('load')
# status.register('temp', format='0.f°C')
status.register(
    'battery',
    battery_ident='ALL',
    format='{status}{vertical_bar}({consumption:.2f}W){remaining:%E%hh:%Mm}',
    alert=True,
    alert_percentage=5,
    status={
        'DIS': '🔋',
        'CHR': '🔌',
        'FULL': ''
    },
)

status.register(
    'network',
    interface='wlp4s0',
    format_up='{v4cidr}({essid})',
    format_down='',
)

status.register(
    'network',
    interface='enp0s31f6',
    format_up='{v4cidr}',
    format_down='',
)

status.register(
    'disk',
    path='/',
    format='{avail:.1f}G'
)

status.register(
    'mail',
    format='{unread}',
    format_plural = "{account}{unread}",
    backends=[
        MaildirMail(account='🏣', directory=expanduser('~/Mail/tangible/INBOX/'))
    ],
)

status.register(
    'mail',
    format='{unread}',
    format_plural = "{account}{unread}",
    backends=[
        MaildirMail(account='📧', directory=expanduser('~/Mail/Personal/INBOX/')),
    ],
)

status.register(
    'pulseaudio',
    format='🔉{volume}%',
    format_muted='🔇',
)

status.register(
    'updates',
    format='{count}!',
    format_no_updates='',
    backends=[
        AptGet()
    ]
)

status.run()