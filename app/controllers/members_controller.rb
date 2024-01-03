class MembersController < ApplicationController
  def index
    if params[:search].present?
      search_members
    else
      @members = Member.all.order(name: :asc).page(params[:page])
    end
  end

  def create
    begin
      ActiveRecord::Base.transaction do
        create_member(create_params)
      end
      flash[:success] = "Member created successfully."
    rescue => e
      flash[:error] = "Error creating member: #{e.message}"
    end

    redirect_to members_new_path
  end

  def new; end

  private

  def create_member(params)
    Member.create!(params)
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

  def create_params
    params.require(:member).permit(:name, :email, :phone_number, :member_type)
  end
end
