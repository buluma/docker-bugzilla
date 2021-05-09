# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# This Source Code Form is "Incompatible With Secondary Licenses", as
# defined by the Mozilla Public License, v. 2.0.

# FROM bugzilla/bugzilla-ci
FROM bugzilla/bugzilla-dev
LABEL maintainer="bulumaknightgmail.com"

# Copy setup scripts
COPY scripts/* /usr/local/bin/
RUN chmod 755 /usr/local/bin/*

COPY conf/checksetup_answers.txt $BUGZILLA_WWW/checksetup_answers.txt
RUN bugzilla_config.sh
RUN su - $BUGZILLA_USER -c dev_config.sh

RUN chown -R $BUGZILLA_USER.$BUGZILLA_USER $BUGZILLA_WWW /home/$BUGZILLA_USER

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
