# frozen_string_literal: true

class Api::Events::BlocksController < ApplicationController
  def create
    @block = Event::Block.new(create_block_params)
    return head :created if @block.save

    render json: @block.errors, status: :unprocessable_entity
  end

  private

  def create_block_params
    params.require(:block)
      .permit(%i[doctor_id start_time end_time description])
  end
end
