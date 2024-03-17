class ArchivedMembersController < ApplicationController
  include MembersSearchable

  def index
    if params[:search].present?
      search_members(archived: true)
    else
      @members = Member.inactive.order(name: :asc).page(params[:page])
    end
  end
end
