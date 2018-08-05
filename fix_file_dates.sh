
export NEWDATE_OPTIONS='year=365_day'

stampo=$( r.date -nS ${2} )

~/bin/fstzapdate  -IMENT ${1}  -STAMPO $stampo
