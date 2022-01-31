# coding: utf8
from i3pystatus import Status
from os.path import expanduser
from i3pystatus.mail.maildir import MaildirMail
# from i3pystatus.mail.notmuchmail import  Notmuch
from i3pystatus.updates.aptget import AptGet
import i3pystatus.network

status = Status()

# status.register('xkblayout', layouts=['azerty', 'fr bepo', 'us qwerty'])
status.register('clock', format='%a %d-%m %H:%M')
status.register(
    'pomodoro',
    sound='/usr/share/sounds/sound-icons/pipe.wav',
    pomodoro_duration=45 * 60,
    break_duration=5 * 60,
    long_break_duration=15 * 60,
    inactive_format="🍅",
)
status.register('timer', format_stopped='⏱')

def cidr4(addr, mask):
    return "{addr}/{bits}".format(
        addr='…'+'.'.join(addr.split('.')[-2:]),
        bits=i3pystatus.network.prefix4(mask)
    )

i3pystatus.network.cidr4 = cidr4

# status.register('xkblayout', layouts=['fr bepo', 'fr azerty', 'en qwerty'])
# status.register('load')
# status.register('temp', format='0.f°C')
status.register(
    'battery',
    battery_ident='ALL',
    format='{status}{vertical_bar}{remaining:%E%hh:%Mm}',
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
    format_up='{v4cidr}({essid:.6})',
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

# status.register(
#     'mail',
#     format='{unread}',
#     format_plural = "{account}{unread}",
#     backends=[
#         Notmuch(
#             db_path='/home/gabriel/Mail/',
#             query=''
#             # account='📬',
#             # directory=expanduser('~/Mail/tshirtman.dev/INBOX/')
#         ),
#     ],
# )

# status.register(
#     'mail',
#     format='{unread}',
#     format_plural = "{account}{unread}",
#     backends=[
#         MaildirMail(
#             account='📬',
#             directory=expanduser('~/Mail/tshirtman.dev/INBOX/')
#         ),
#     ],
# )

# status.register(
#     'mail',
#     format='{unread}',
#     format_plural = "{account}{unread}",
#     backends=[
#         MaildirMail(
#             account='📬',
#             directory=expanduser('~/Mail/Personal/INBOX/')
#         ),
#     ],
# )

status.register(
    'pulseaudio',
    format='🔉{volume}%',
    format_muted='🔇',
)

# status.register(
#     'updates',
#     format='{count}!',
#     format_no_updates='',
#     backends=[
#         AptGet()
#     ]
# )

# status.register(
#     'rofication'
# )

status.register(
    'temp',
    lm_sensors_enabled=True,
    dynamic_color=True,
    urgent_on='warning',
    format="{Package_id_0}°C {Core_0_bar}{Core_1_bar}",
)
status.register('cpu_usage_graph')
status.register(
    'bitstamp',
    url='https://www.bitstamp.net/api/v2/ticker/btceur',
    colorize=True,
    color_up="#00BB00",
    color_down="#BB6666",
    interval=5,
    format='{status}{last:,.02f}€/₿',
)

status.register('backlight', format='{percentage}%')
status.run()
