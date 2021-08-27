# frozen_string_literal: true

require 'base64'
require 'digest'

class TextMessage
  attr_accessor :encryptor
  attr_reader :original_message

  def initialize(original_message, encryptor)
    @original_message = original_message
    @encryptor = encryptor
  end

  def encrypt_me
    encryptor.encrypt(self)
  end
end

class SimpleEncryptor
  ALPHABET = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
  ENCODING = 'MOhqm0PnycUZeLdK8YvDCgNfb7FJtiHT52BrxoAkas9RWlXpEujSGI64VzQ31w'

  def encrypt(context)
    context.original_message.tr(ALPHABET, ENCODING)
  end
end

class Base64Encryptor
  def encrypt(context)
    Base64.encode64(context.original_message)
  end
end

class MD5Encryptor
  def encrypt(context)
    Digest::MD5.hexdigest context.original_message
  end
end

message = TextMessage.new('my secret secret message', SimpleEncryptor.new)
puts message.encrypt_me

message.encryptor = Base64Encryptor.new
puts message.encrypt_me

message.encryptor = MD5Encryptor.new
puts message.encrypt_me
