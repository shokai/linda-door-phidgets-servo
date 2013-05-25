Linda Door (Phidgets Servo)
===========================
open door-lock with RocketIO::Linda and Phidgets Servo-motor

* https://github.com/shokai/linda-door-phidgets-servo


Dependencies
------------
- (Phidgets Servo-motor)[http://www.phidgets.com]
- Ruby 1.8.7 ~ 2.0.0


Install Dependencies
--------------------

    % gem install bundler foreman
    % bundle install


Run
---

set ENV var "LINDA_BASE" and "LINDA_SPACE"

    % export LINDA_BASE=http://linda.example.com
    % export LINDA_SPACE=test
    % bundle exec ruby linda-door-phidgets-servo.rb


oneline

    % LINDA_BASE=http://linda.example.com LINDA_SPACE=test  bundle exec ruby linda-door-phidgets-servo.rb


Install as Service
------------------

for launchd (Mac OSX)

    % sudo foreman export launchd /Library/LaunchDaemons/ --app linda-door -u `whoami`
    % sudo launchctl load -w /Library/LaunchDaemons/linda-door-servo-1.plist


for upstart (Ubuntu)

    % sudo foreman export upstart /etc/init/ --app linda-door -d `pwd` -u `whoami`
    % sudo service linda-door start
