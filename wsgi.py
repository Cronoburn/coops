import sys

project_home='/home/eric/sites/coopslake'
if project_home not in sys.path:
    sys.path = [project_home] + sys.path

from coop import app as application  # noqa