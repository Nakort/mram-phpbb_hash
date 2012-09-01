require "mram-phpbb_hash/version"

require 'digest/md5'

module Mram
  module PhpbbHash
    def self.check_hash(password, hash)
      itoa64 = './0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';

      if hash.length == 34 then
        calc_phpbb_hash(password, hash, itoa64) == hash
      else
        calc_md5(password) == hash
      end
    end

    def self.calc_md5(password)
      return Digest::MD5.hexdigest(password)
    end

    def self.calc_phpbb_hash(password, setting, itoa64)
      # Check for correct hash
      hashtype = setting[0..2]
      raise(Exception::WrongHashTypeError, "unknown hash type: '#{hashtype}'") unless [ "$H$", "$P$" ].include?(hashtype)

      count_log2 = itoa64.index(setting[3])
      raise(Exception::WtfError, "WTF: count_log2 is #{count_log2}") unless (7..30).include? count_log2

      count = 1 << count_log2
      salt = setting[4, 8]
      raise(Exception::WtfError, "WTF: salt.length is not 8") unless salt.length == 8
      
      hash = Digest::MD5.digest(salt + password)
      count.times { hash = Digest::MD5.digest(hash + password) }

      setting[0, 12] + _hash_encode64(hash, 16, itoa64)
    end

    def self._hash_encode64(input, count, itoa64)
      output = ""

      i = 0
      begin
        value = input[i].ord
        i += 1

        output += itoa64[value & 0x3f]
        value |= (input[i].ord << 8) if i < count
        output += itoa64[(value >> 6) & 0x3f]

        break if i >= count
        i += 1

        value |= (input[i].ord << 16) if i < count
        output += itoa64[(value >> 12) & 0x3f]

        break if i >= count
        i += 1
        
        output += itoa64[(value >> 18) & 0x3f]
      end while i < count

      output
    end
  end

  module Exception
    class WrongHashTypeError < StandardError; end
    class WtfError < StandardError; end
  end
end
