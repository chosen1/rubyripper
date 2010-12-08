#!/usr/bin/env ruby
#    Rubyripper - A secure ripper for Linux/BSD/OSX
#    Copyright (C) 2007 - 2010  Bouke Woudstra (boukewoudstra@gmail.com)
#
#    This file is part of Rubyripper. Rubyripper is free software: you can 
#    redistribute it and/or modify it under the terms of the GNU General
#    Public License as published by the Free Software Foundation, either 
#    version 3 of the License, or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>

require 'rubyripper/freedb/freedbString.rb'

# A class to test the freedbstring generation
class TC_FreedbString < Test::Unit::TestCase

	# pure AudioDisc
	def test_NormalAudioDisc
		freedb004 = "7F087C0A 10 150 13359 36689 53647 68322 81247 87332 \
106882 122368 124230 2174"
		start004 = {1=>0, 2=>13209, 3=>36539, 4=>53497, 5=>68172, 6=>81097, 
			7=>87182, 8=>106732, 9=>122218, 10=>124080}
		length004 = {1=>13209, 2=>23330, 3=>16958, 4=>14675, 5=>12925,
6=>6085, 7=>19550, 8=>15486, 9=>1862, 10=>38839}
		disc004 = FakeDisc.new(start004, length004)

		string1 = FreedbString.new($deps, '/dev/cdrom', disc004, 'manual')
		string2 = FreedbString.new($deps, '/dev/cdrom', disc004, freedb004)

		assert_equal(freedb004, string1.getFreedbString.upcase)
		assert_equal(freedb004.split()[0], string1.getDiscId.upcase)
		assert_equal(freedb004, string2.getFreedbString.upcase)
		assert_equal(freedb004.split()[0], string2.getDiscId.upcase)
	end
	
	# testcase for query 05
	def test_AudioDiscDataTrack
		freedb005 = "A111490D 13 150 15477 31850 63087 88235 109277 135597 \
157652 173957 191547 205707 231185 275347 4427"
		start005 = {1=>0, 2=>15327, 3=>31700, 4=>62937, 5=>88085, 6=>109127, 
7=>135447, 8=>157502, 9=>173807, 10=>191397, 11=>205557, 12=>231035, 
13=>275197}
		length005 = {1=>15327, 2=>16373, 3=>31237, 4=>25148, 5=>21042, 
6=>26320, 7=>22055, 8=>16305, 9=>17590, 10=>14160, 11=>25478, 12=>32762,
13=>56709}
		disc005 = FakeDisc.new(start005, length005)		
		string1 = FreedbString.new($deps, '/dev/cdrom', disc005, 'manual')
		string2 = FreedbString.new($deps, '/dev/cdrom', disc005, freedb005)

		assert_equal(freedb005, string1.getFreedbString.upcase)
		assert_equal(freedb005.split()[0], string1.getDiscId.upcase)
		assert_equal(freedb005, string2.getFreedbString.upcase)
		assert_equal(freedb005.split()[0], string2.getDiscId.upcase)
	end
end