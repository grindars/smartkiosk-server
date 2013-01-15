class CollectionsController < ApplicationController
  before_filter :authenticate_terminal

  def create
    if params[:collection].is_a?(Hash)
      # TODO: Update terminal part and remove the compatibility hack
      params[:collection][:session_ids] = params[:collection].delete(:foreign_ids) if params[:collection][:session_ids].blank?
    end

    begin
      collection = @terminal.collections.create! params[:collection]
      render :text => collection.id, :status => 200
    rescue ActiveRecord::RecordInvalid
      render :text => nil, :status => 400
    end
  end
end
