class ArchivedMembersController < ApplicationController
  include Searchable

  def index
    if params[:search].present?
      search_members(archived: true)
    else
      @members = Member.all.where(archived: true).order(name: :asc).page(params[:page])
    end
  end
end
