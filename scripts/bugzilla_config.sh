#!/bin/bash
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# This Source Code Form is "Incompatible With Secondary Licenses", as
# defined by the Mozilla Public License, v. 2.0.

cd $BUGZILLA_WWW

# Configure database
# /usr/bin/mysqld_safe &
# sleep 5
# mysql -u root mysql -e "GRANT ALL PRIVILEGES ON *.* TO bugs@localhost IDENTIFIED BY 'bugs'; FLUSH PRIVILEGES;"
# mysql -u root mysql -e "CREATE DATABASE bugs CHARACTER SET = 'utf8';"

/usr/local/bin/cpanm --installdeps --quiet --notest .

sed -i "s|$db_driver = 'mysql'|$db_driver = 'Sqlite' |g" localconfig

perl checksetup.pl checksetup_answers.txt

sed -i "s|$db_driver = 'mysql'|$db_driver = 'Sqlite' |g" localconfig
perl checksetup.pl checksetup_answers.txt

# mysqladmin -u root shutdown
