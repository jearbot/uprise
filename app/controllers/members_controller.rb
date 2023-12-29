class MembersController < ApplicationController
  def index
    if params[:search].present?
      search_members
    else
      @members = Member.all.order(name: :asc).page(params[:page])
    end
  end

  private

  def search_members
    members_table = Member.arel_table

    search_term = params[:search].downcase if params[:search].present?

    @members = if Member.member_types.keys.include?(search_term)
                Member.where(members_table[:member_type].eq(search_term)).page(params[:page])
               else
                Member.where(
                 members_table[:email].lower.matches("%#{search_term}%").
                 or(members_table[:normalized_phone_number].matches("%#{search_term}%")).
                 or(members_table[:name].lower.matches("%#{search_term}%"))
                ).page(params[:page])
               end
  end
end
