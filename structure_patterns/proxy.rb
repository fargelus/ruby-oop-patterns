# frozen_string_literal: true

module SpamFilter
  def self.is_spam?(msg)
    # magic code is here
  end
end

# == Schema Information
#
# Table name: comments
#
#  id             :integer          not null, primary key
#  message        :string
#  user_id        :integer
#  item_id        :integer
#  spam           :boolean
class Comment < ApplicationRecord
end


##
# proxy
class CommentAntiSpamProxy
  attr_accessor :real_comment
  def initialize(real_comment)
    @real_comment = real_comment
  end

  def method_missing(name, *args)
    answer = real_comment.send(name, *args)
    check_spam if need_to_check_spam?(name, answer)
    answer
  end

  private

  def need_to_check_spam?(name, answer)
    answer == true and (['save', 'update_attributes'].include?(name.to_s))
  end

  def check_spam
    return unless SpamFilter.is_spam?(real_comment.message)
    real_comment.update_attrubutes(spam: true)
  end
end

##
# controller
class CommentsController < ApplicationController
  def create
    @comment = CommentAntiSpamProxy.new(Comment.new(comment_params))
    if @comment.save
      render json: @comment, status: :ok
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    @comment = CommentAntiSpamProxy.new(Comment.find(params[:comment_id]))
    if @comment.update_attributes(comment_params)
      render json: @comment, status: :ok
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :item_id, :message)
  end
end
