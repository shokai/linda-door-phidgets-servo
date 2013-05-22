#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'phidgets-ffi'
require 'sinatra/rocketio/linda/client'

servo = Phidgets::Servo.new

servo.on_attach do |device, obj|
  puts "#{device.device_class} attached"
  device.servos[0].engaged = true
  device.servos[0].type = Phidgets::FFI::ServoType[:default]
end

url = ARGV.shift || "http://linda.masuilab.org"
puts "connecting.. #{url}"
linda = Sinatra::RocketIO::Linda::Client.new url
ts = linda.tuplespace["delta"]

door_open = lambda{
  ts.take ["door", "open"] do |tuple|
    puts tuple
    if servo.attached? and tuple == ["door", "open"]
      servo.servos[0].position = 0
      sleep 2
      servo.servos[0].position = 180
      ts.write ["door", "open", "success"]
    end
    door_open.call
  end
}

linda.io.on :connect do
  puts "connect!! <#{io.session}>"
  door_open.call
end

loop do
end
